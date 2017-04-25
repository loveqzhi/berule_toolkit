<?php

/**
 * @ Api file Mail.php
 */
namespace Api\Mail;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Api;
use Entity;

class Mail{

    /**
     * 获取我的邮件接口
     * @route /api/mail/interface
     * @access
     * @param $token
     * @return array
     */
    public static function myserver($request) {
        logger()->debug(var_export($_REQUEST,true));
        $token = $request->getParameter('token');
        if(empty($token) || ($uid=Api\Token\Token::check($token))==false) {
            return new Response(false,10009); 
        }

        return new Response(Entity\User\User::load(
                entity_request(array('uid'=>$uid)))->field_user_mail);
    }
    /**
     * 发送邮件
     * @route /api/mail/send/{host}
     * @access
     * @param $token
     * @param $data ('address','subject','body')
     * @return boolean
     */
    public static function send($request) {
        $token = $request->post->getParameter('token');
        $host  = $request->route->getParameter('host');
        $data  = $request->post->getParameter('data');
        if(empty($token) || ($uid=Api\Token\Token::check($token))==false) {
            return new Response(false,10009); 
        }
        if(empty($host) || ($config=Entity\User\User::getUserMailOptionByName($uid,$host))==false) {
            return new Response(false,10010);
        }
        $sendTo = explode(";",$data['address']);
        $error_address = $sendMail = array();
        foreach($sendTo as $k=>$email) {
            if(!preg_match("/^([_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/", $email)) {
                $error_address[] = $email;
            }
            else {
                $sendMail[] = $email;
            }
        }
        if(empty($sendMail)) {
            return new Response(false,10011);
        }
        $data['address'] = implode(";",$sendMail);
        $array = array(
            'type'      => 1,
            'uid'       => $uid,
            'msgid'     => self::getTaskId($uid),
            'channel'   => $config['name'],
            'data'      => serialize(array('config'=>$config,'data'=>$data)),
            'status'    => 0,
            'created'   => time(),
        );
        db_insert("task")->fields($array)->execute();
        return new Response(array(
                    'msgid'=>$array['msgid'],
                    'error_addres'=>implode(";",$error_address)
                ));
    }
    //getTaskId
    public static function getTaskId($uid) {
        list($usec, $sec) = explode(' ', microtime());
        return strtoupper(substr(md5($uid),0,2)) . date('YmdHis', $sec) . (int) ($usec * 1000000);
    }

}
