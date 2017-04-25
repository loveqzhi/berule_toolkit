<?php

/**
 * @ Api file Sms.php
 */
namespace Api\Sms;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Api;
use Entity;

class Sms{

    /**
     * 获取我的短信接口
     * @route /api/sms/interface
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
                entity_request(array('uid'=>$uid)))->field_user_sms);
    }
    /**
     * 发送短信
     * @route /api/sms/send/{host}
     * @access
     * @param $token
     * @param $data ('phone'=>多个手机号用半角,连接,'content'=>内容，不包括签名,'sendTime'=>发送时间)
     * @return boolean
     */
    public static function send($request) {
        $token = $request->post->getParameter('token');
        $host  = $request->route->getParameter('host');
        $data  = $request->post->getParameter('data');
        if(empty($token) || ($uid=Api\Token\Token::check($token))==false) {
            return new Response(false,10009); 
        }
        if(empty($host) || ($config=Entity\User\User::getUserSmsOptionByName($uid,$host))==false) {
            return new Response(false,10013);
        }
        $sendTo = explode(",",$data['phone']);
        $error_phones = $sendSms = $msgids = array();
        foreach($sendTo as $k=>$phone) {
            if(!preg_match("/^1[34578]\d{9}$/",$phone)) {
                $error_phones[] = $phone;
            }
            else {
                $sendSms[] = $phone;
            }
        }
        if(empty($sendSms)) {
            return new Response(false,10012);
        }
		foreach($sendSms as $sphone) {
			$sdata = array(
				'phone'=>$sphone,
				'content'=>'【'.$config['sign'].'】'.$data['content'],
				'sendTime'=>isset($data['sendTime'])? $data['sendTime'] : '',
			);
			$msgids[] = $msgid = self::getMsgId($uid);
			$array = array(
				'type'      => 2,
				'uid'       => $uid,
				'msgid'     => $msgid,
				'channel'   => $config['name'],
				'data'      => serialize(array('config'=>$config,'data'=>$sdata)),
				'status'    => 0,
				'created'   => time(),
			);
			db_insert("task")->fields($array)->execute();
			$sdata = $array = $msgid = null;
		}
        
        return new Response(array(
                    'msgids'=>implode(",",$msgids),
                    'error_phones'=>implode(",",$error_phones)
                ));
    }
    //getMsgId
    public static function getMsgId($uid) {
        list($usec, $sec) = explode(' ', microtime());
        return strtoupper(substr(md5($uid),0,2)) . date('YmdHis', $sec) . (int) ($usec * 1000000);
    }

}
