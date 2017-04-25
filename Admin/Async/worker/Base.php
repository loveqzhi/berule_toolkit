<?php
/**
 * @ file Base.php 
 */

set_time_limit(0);
ini_set('memory_limit', '64M');
//include framework
require_once dirname(dirname(dirname(dirname(__DIR__)))) . '/Pyramid/Pyramid.php';
//include config 
require_once dirname(dirname(dirname(__DIR__))) . '/config.php';

class Base {
    //handle $serv
    public $serv;
    
    //async config
    public static $async;
    
    //async id
    public static $async_id;
    
    public function __construct($async_id){
        self::$async_id = $async_id;     
        self::$async = db_select("async","a")->fields("a")->condition("id",$async_id)->execute()->fetch();
        if (!empty(self::$async)) {
            $sets = array(
                'worker_num'      => self::$async->worker_num,
                'daemonize'     => true,
                'task_worker_num' => self::$async->task_worker_num,
                'max_request'     => self::$async->max_request,
                'debug_mode'      => self::$async->debug_mode,
                'log_file'        => self::$async->log_file,
            );
            $this->serv = new swoole_server("127.0.0.1", self::$async->work_port);
            $this->serv->set($sets);
            $this->serv->on('Start', array($this, 'onStart'));
            $this->serv->on('Connect', array($this, 'onConnect'));
            $this->serv->on('Receive', array($this, 'onReceive'));
            $this->serv->on('Task', array($this, 'onTask'));
            $this->serv->on('Finish', array($this, 'onFinish'));
            $this->serv->on('Timer', array($this, 'onTimer'));
            $this->serv->on('WorkerStart', array($this, 'onWorkerStart'));
            
            $this->serv->start();
        }
        
    }
    
    /**
     * worker workerStart 周期调度执行
     */
    public function onWorkerStart($serv,$worker_id) {
        $this->serv->addtimer(5000);//周期执行发送
        if ($worker_id == 0) {
            //只有一个子进程跑， 将待发送数据送入redis
            $this->serv->addtimer(5001);
        }
    }
    
    /**
     * 链接work
     */
    public function onConnect($serv, $fd, $from_id){
        
        logger()->debug("Connect ".self::$async->name." work success: ".$fd);
    }
    /**
     * after start work
     */
    public function onStart($serv){
        $this->master_pid  = $this->serv->master_pid;
        $this->manager_pid = $this->serv->manager_pid;
        variable()->set('swoole_'.self::$async_id,array('master_pid'=>$this->master_pid,'manager_pid'=>$this->manager_pid));
        logger()->debug("Start to runing worker for ".self::$async->name);
    }
    
    /**
     * worker receive
     */
    public function onReceive($serv,$fd,$from_id,$data) {
		if ($data) {
			//执行调度        
			logger()->debug(self::$async->name." work receive data is:".$data);
			$task_id = $serv->task($data);
		}
    }
    
    /**
     * worker task
     */
    public function onTask($serv,$task_id,$from_id,$data) {
        logger()->debug("task receive data is:".$data);
        //code for something ...
        
        $serv->finish($data." -> OK");
    }
    
    /**
     * 关闭当前链接
     */
    public function onFinish($serv,$task_id,$data){
        
        logger()->debug("finish data is:".$data."\n");
    }

}