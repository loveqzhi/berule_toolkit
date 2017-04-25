<?php

/**
 * @ Api file Wechat.php
 */
namespace Api\Wechat;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Api\Wechat\WechatHttp as WechatHttp;
use Api\Wechat\Prpcrypt as Prpcrypt;
use Entity;

class Wechat extends WechatAPI {
    public static $config;
    /**
     * 微信入口api
     * @route /api/wechat/{url}
     * @access
     */
    public static function api($request) {
        //打印调试
        $w_get = $request->get->getParameters();
        $w_post = file_get_contents('php://input');
        logger()->debug("Weixin Get data: ".var_export($w_get,true));
        logger()->debug("Weixin Post data: ".var_export($w_post,true));

        $request->params->setParameter('qyconfig',self::getConfigByUrl($request->route->getParameter('url')));
        $back = self::handleEvent($request);
        logger()->debug($back);
        return new Response($back);
    }
    
    protected static function getConfigByUrl($url) {
        if (empty($url)) return false;
        $w = db_select("data_field_user_weixin","w")
                ->fields("w")
                ->condition("field_user_weixin_url",$url)
                ->execute()
                ->fetch();
        if (empty($w)) {
            return false;
        } else {
            $user = Entity\User\User::load(entity_request(array('uid'=>$w)));
            return $user->field_user_weixin[0];
        }
    }
    
    /*
     * 事件分发
     */
    public static function eventDispatch($request,$requestxml) {
        $xml   = @simplexml_load_string($requestxml, 'SimpleXMLElement', LIBXML_NOCDATA | LIBXML_NOBLANKS);
        $xml_array = WechatHttp::extractXML($xml);
        logger()->debug("to send back request is ".var_export($xml_array,true));
        $event = strtolower($xml_array['MsgType']);
        if ($event == 'event') {
            switch (strtoupper($xml_array['Event'])) { 
                case 'LOCATION':
                    $method = 'onReportLocation';
                    break;
                default:
                    $method = 'on' . ucfirst($xml_array['Event']);
                    break;
            }
        } elseif (strpos('text,image,voice,vedio,location,link', $event) !== false) {
            $method = 'on' . ucfirst($event);
        } else {
            $method = 'unknown';
        }
        
        return self::$method($request,$xml_array);
    }
    
    /*
     * 事件调度
     */
    public static function handleEvent($request) {
        $check = self::checkAccess($request->params->getParameter('qyconfig'));
        if ($check === true) {       
            return self::eventDispatch($request,self::$requestxml);
        } else {
            return $check;
        }
    }
    
    //关注时 被动回复消息给员工
    public static function onSubscribe($request,$xml_array) {
        $output = array(
            'Encrypt' => '',
            'MsgSignature' => '',
            'TimeStamp' => self::$timestamp,
            'Nonce'     => self::$nonce,
        );
        $encrypt = array(
            'ToUserName'    => $xml_array['FromUserName'],
            'FromUserName'  => $request->params->getParameter('qyconfig')['corpid'],
            'CreateTime'    => time(),
            'MsgType'       => 'text',
            'Content'       => '谢谢关注我们的微信企业号!',
        );
        $encrypt_xml = WechatHttp::response($encrypt);
        logger()->debug("encrypt_xml is ".$encrypt_xml);
        $pc = new Prpcrypt($request->params->getParameter('qyconfig')['encodingaeskey']);
        $result = $pc->encrypt($encrypt_xml,$request->params->getParameter('qyconfig')['corpid']);
        if ($result[0] == 0) {
            $output['Encrypt'] = $result[1];
            $hash = WechatAPI::getSha1($request->params->getParameter('qyconfig')['token'], self::$timestamp, self::$nonce,$output['Encrypt']);
            $output['MsgSignature'] = $hash;
        }
        
        
        return new Response(WechatHttp::response($output));
    }
    
    //收到输入关键字时
    public static function onText($request,$xml_array) {
        $output = array(
            "touser"    => $xml_array['FromUserName'],
            "msgtype"   => "text",
            "toparty"   => 2,
            "totag"     => 1,
            "agentid"   => 0,
            "text"      => array(
               "content" => "谢谢关注我们的微信企业号!【".$xml_array['Content']."】",
            ),
            "safe"      => "0"
        );
        logger()->debug("######### Call Back array is:".var_export($output,true));
        $res = self::send($request,$output);
        logger()->debug("#### weixin return ".$res[1]);
    }
    
}
