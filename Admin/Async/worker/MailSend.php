<?php 

/**
 * @file 执行邮件发送任务
 * @usage 
 * @author  loveqzhi@hotmail.com
 * @update  2015.05.25
 */
require_once 'Base.php';

class MailSend extends Base{
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
                //遍历redis中邮件业务数据 并执行发送
                while($id = redis()->lPop('MailTask')) {
                    logger()->debug("Mail server receive a Task id: ".$id);
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
            ->condition("t.type",1)
            ->condition("t.status",0)
            ->range(0,20);

        while($data = $query->execute()->fetchCol()) {           
            foreach ($data as $id) {
                redis()->rPush('MailTask',$id);
                logger()->debug("Add Task id for Mail: ".$id);
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
        try {
            $mail = new Pyramid\Vendor\Mailer\Mailer($sends['config']);
            $res = $mail->send($sends['data']);
        } catch (Exception $e) { //发送邮件失败
            logger()->debug("Send email ERROR To ".$sends['data']['address']." ".$e->getMessage());
            throw new Exception("send mail failed",$id);           
        }
        $array = array(
            'uid'   => $task->uid,
            'msgid' => $task->msgid,
            'channel' => $task->channel,
            'address' => $sends['data']['address'],
            'subject' => $sends['data']['subject'],
            'status'  => ($res)?1:4,
            'created' => $task->created,
            'updated' => time(),
        );
        $thisdb = db_transaction(); //开启事务
        try{
            db_insert("mail")->fields($array)->execute();
            db_delete("task")->condition("id",$id)->execute();
            logger()->debug("Send a email success: To ".$sends['data']['address']);
            $sends = $mail = $thisdb = $array = null;
        } catch (Exception $e) {
            $thisdb->rollback(); //回滚
            logger()->debug("Send a email Fail: To ".$sends['data']['address']." ".$e->getMessage());
            $sends = $mail = $thisdb = $array = null;
            throw new Exception("send mail failed",$id);            
        }
        
    }
     
}

//construct class
new MailSend($argv[1]);
