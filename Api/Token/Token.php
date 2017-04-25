<?php

/**
 * @ Api file token.php
 */
namespace Api\Token;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Entity;

class Token {

    /**
     * @ token max request time 
     */
    static $token_max_time = 500;

    /**
     * 申请Token
     * @route /api/token
     * @access
     * @param $appid
     * @param $mkey md5(appid+secret)
     * @return json (token": "blAxxxxx","expired": 1419499089)
     */
    public static function getToken($request) {
        $appid = $request->get('appid');
        $mkey  = $request->get('mkey');
        if(empty($appid) || empty($mkey)) { //参数必填
            return new Response(array(),10005);
        }
        if(($application = Entity\Application\Application::loadByAppid(
            entity_request(array('appid'=>$appid)))) == null) {
            return new Response(array(),10006);
        }
        if($mkey != md5($appid . $application->secret)) {
            return new Response(array(),10007);
        }
        $token = db_select("tokens","t")
                    ->fields("t")
                    ->condition("date",date('Ymd'))
                    ->condition("uid",$application->uid)
                    ->execute()
                    ->fetch();
        if (!empty($application->token_max_time)) {
            self::$token_max_time = $application->token_max_time;
        }
        if(!empty($token) && $token->total > self::$token_max_time) {
            db_update("tokens")
                ->fields(array("expired"=>1))
                ->condition("date",date('Ymd'))
                ->condition("uid",$application->uid)
                ->execute();
            return new Response(array(),10008);
        }
        $array = array(
            'token' => Entity\Application\Application::createAppid($application->uid*1000),
            'expired' => time() + 7200,
            'updated' => time(),
        ); 
        db_merge("tokens")
            ->key(array(
                'date' => date('Ymd'),
                'uid'  => $application->uid,
            ))
            ->fields($array)
            ->expression('total','`total`+1')
            ->execute();
        unset($array['updated']); 
            
        return new Response($array);
    }

    /**
     * 校验Token是否有效
     * @route
     * @access
     * @param $token
     * @return boolean
     */
    public static function check($token=null) {
        if(empty($token)) {
            return false; 
        }
        $data = db_select("tokens","t")
                ->fields("t")
                ->condition("token",$token)
                ->execute()
                ->fetch();
        if(empty($data) || time() > $data->expired) {
            return false;
        } else {
            return $data->uid;
        }
    }

}
