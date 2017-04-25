<?php

/**
 * @ Admin file Wechat.php
 */
namespace Admin\Wechat;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Api\Wechat\WechatAPI as WechatAPI;
use Api\Wechat\WechatHttp as WechatHttp;
use Api\Wechat\Prpcrypt as Prpcrypt;
use Entity;

class Wechat extends WechatAPI {
    /**
     * 企业员工管理
     * @route /wechat/user
     * @access
     */
    public static function user($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
        
        $request->params->setParameter('qyconfig',$user->field_user_weixin[0]);
        $res = array(
            'department'=> WechatAPI::department($request),
            'userlist'  => WechatAPI::getUserList($request),
            'HOST'      => $request->getSchemeAndHttpHost(),
            'menus'     => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
            'gets'      => $request->get->getParameters(),
        );
        //print_r($res['department']);exit;
        return new Response(theme()->render('weixin-user.html',$res));
    }
    
    /**
     * 微信配置
     * @route /wechat/setting
     * @access admin_access
     * @return string 
     */
    public static function setting($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
        $res = array(
            'HOST'   => $request->getSchemeAndHttpHost(),
            'wechat' => Entity\User\User::load(entity_request(array('uid'=>$user->uid)))->field_user_weixin[0],
            'menus'  => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );
        return new Response(theme()->render('weixin-setting.html',$res));
    }
    
    /**
     * 账号配置保存
     * @route /wechat/setting/save
     * @access admin_access
     * @return string 
     */
    public static function setting_save($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
        $user = Entity\User\User::load(entity_request(array('uid'=>$user->uid)));
        if ($post_data = $request->post->getParameters()) {
            $post_data['field_user_weixin'][0]['options'] = isset($post_data['field_user_weixin'][0]['options']) ? 
					serialize($post_data['field_user_weixin'][0]['options']) : serialize(array());
            $url = $post_data['field_user_weixin'][0]['url'];   //检查唯一
            $check_url = db_select("data_field_user_weixin","w")
                            ->fields("w",array("entity_id"))
                            ->condition("field_user_weixin_url",$url)
                            ->condition("entity_id",$user->uid,"<>")
                            ->execute()
                            ->fetch();
            if (!empty($check_url)) {
                return new Response(json_encode(
                                array('status'=>'error','msg'=>'回调url已被使用，请更换')),'200',
                                array('Content-Type'=>'application/json'));
            }
            $array = array(
                'uid' => $user->uid,
                'field_user_weixin' => $post_data['field_user_weixin'],
            );
            Entity\User\User::update(entity_request($array));
            return new Response(json_encode(
                                array('status'=>'success','msg'=>'ok')),'200',
                                array('Content-Type'=>'application/json'));
        }
        else {
            return new RedirectResponse($request->getUriForPath('/wechat/setting'),'0');       
        }
    }
    

    
}
