<?php 

/**
 * @file 执行短信发送任务
 * @usage 
 * @author  loveqzhi@hotmail.com
 * @update 2015.05.25
 */
require_once 'Base.php';

class SmsSend extends Base{
    //初始化Server
    public function __construct($async_id){
    
        parent::__construct($async_id);
    }
       

    /**
     * worker timer
     */
    public function onTimer($serv,$interval) {
        switch($interval) {
            case 5000:
                //遍历redis中短信业务数据 并执行发送
                while($id = redis()->lPop('SmsTask')) {
                    logger()->debug("Sms server receive a Task id: ".$id);
                    try {
                        self::runing($id);  //执行发送
                    }  catch (Exception $e) {
                        //异常
                        $id = $e->getCode();
                        db_update("task")
                            ->fields(array('status'=>0))
                            ->condition("id",$id)
                            ->execute();
                        $id = null;
                        logger()->debug("有异常抛出 ".$e->getMessage());
                    }
                }
            break;
            case 5001:
                //遍历待发数据
                self::getTask();
            break;
        }   
    }
    
    //遍历任务表把邮件业务数据压入redis
    public static function getTask(){
        $query = db_select("task","t")
            ->fields("t",array("id"))
            ->condition("t.type",2)
            ->condition("t.status",0)
            ->range(0,20);

        while($data = $query->execute()->fetchCol()) {           
            foreach ($data as $id) {
                redis()->rPush('SmsTask',$id);
                logger()->debug("Add Task id for Sms: ".$id);
                $tids[] = $id;               
            }
            if ($tids) {
                db_update("task")
                        ->fields(array("status"=>1))
                        ->condition("id",$tids)
                        ->execute();
            }
            $tids = $data = null;          
        }
        $query = null;
    }
    
    //执行发送任务
    public static function runing($id) {
        $task = db_select("task","t")
                        ->fields("t")
                        ->condition("id",$id)
                        ->execute()
                        ->fetch();
        $sends = unserialize($task->data);
        $param = array(
            'userid'	=> $sends['config']['userid'],
            'account'	=> $sends['config']['account'],
            'password'	=> $sends['config']['password'],
            'mobile'	=> $sends['data']['phone'],
            'content'	=> $sends['data']['content'],
            'sendTime'  => isset($sends['data']['sendTime'])? $sends['data']['sendTime'] : '',
            'action'    => 'send',
            'extno'		=> '',
        );
        try {
            $response = self::sms_send($param);
        } catch (Exception $e) {
            logger()->debug("Send sms ERROR To ".$sends['data']['phone']." ".$e->getMessage());
            throw new Exception("send sms failed",$id);
        }
        
        $array = array(
            'uid'	  => $task->uid,
            'msgid'   => $task->msgid,
            'taskid'  => isset($response['taskid'])? $response['taskid'] : '',
            'channel' => $task->channel,
            'phone'   => $sends['data']['phone'],
            'content' => $sends['data']['content'],
            'status'  => ($response['status']=='Success' || $response['status']=='Sucess' )?1:2,
            'created' => $task->created,
            'updated' => time(),
        );
        $thisdb = db_transaction(); //开启事务
        try{
            db_insert("sms")->fields($array)->execute();
            db_delete("task")->condition("id",$id)->execute();
            logger()->debug("Send a sms success: To ".$sends['data']['phone']);
            $sends = $response = $thisdb = $array = null;
            return 'success';
        } catch (Exception $e) {
            $thisdb->rollback(); //回滚
            logger()->debug("Send a sms faild: To ".$sends['data']['phone']);
            $sends = $response = $thisdb = $array = null;
            throw new Exception("send sms failed",$id);
        }
        
    }
    
    //beanli 接口 发送
	public static function sms_send($param) {
		$url  = "http://218.244.141.161:8888/sms.aspx";
		$response = curl($url,array(),$param);
		logger()->debug("send sms data is:".var_export($param,true));
		logger()->debug("response:".$response[1]);
		$status  = self::getString($response[1],'<returnstatus>','</returnstatus>');
		$message = self::getString($response[1],'<message>','</message>');
		$taskid  = self::getString($response[1],'<taskID>','</taskID>');
		logger()->debug("Send sms return is status:".$status." message:".$message);
		
		return array(
			'status' => $status,
			'message' => $message,
			'taskid'  => $taskid,
		);
	}

	public static function getString($string,$l,$r) {
		$str1 = explode($l,$string);
		return explode($r,$str1[1])[0];
	}
     
}

//construct class
new SmsSend($argv[1]);
