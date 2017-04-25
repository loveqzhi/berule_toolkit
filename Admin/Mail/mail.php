<?php

/**
 * @ Api file mail.php
 * @ public for Back-stage management
 * @ 
 */
namespace Admin\Mail;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Entity;
use Admin;
use Pyramid;

class Mail {

    /**
     * 邮箱配置
     * @route /mail/setting
     * @access admin_access
     * @return string 
     */
    public static function setting($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
        $res = array(
            'HOST'  => $request->getSchemeAndHttpHost(),
            'list'  => Entity\User\User::load(entity_request(array('uid'=>$user->uid)))->field_user_mail,
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );
        return new Response(theme()->render('mail-setting.html',$res));
    }
    /**
     * 新增邮箱配置
     * @route /mail/setting/add
     * @access admin_access
     * @return string 
     */
    public static function setting_add($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
        $user = Entity\User\User::load(entity_request(array('uid'=>$user->uid)));
        if ($post_data = $request->post->getParameters()) {
            $key = array_keys($post_data['field_user_mail'])[0];
            $post_data['field_user_mail'][$key]['options'] = isset($post_data['field_user_mail'][$key]['options']) ? 
					serialize($post_data['field_user_mail'][$key]['options']) : serialize(array());
            $array = array(
                'uid' => $user->uid,
                'field_user_mail' => $post_data['field_user_mail'] + $user->field_user_mail,
            );
            ksort($array['field_user_mail']);
            self::checkEmail($array['field_user_mail']);
            Entity\User\User::update(entity_request($array));
            return new Response(json_encode(
                                array('status'=>'success','msg'=>'ok')),'200',
                                array('Content-Type'=>'application/json'));
        }
        else {
            if(!empty($user->field_user_mail)) {
                $maxid = str_replace('mail','',max(array_column($user->field_user_mail,'name')));
            } else {
                $maxid = 0;
            }
            $res = array(
                'maxid' => $maxid,
                'mails' => Entity\User\User::load(entity_request(array('uid'=>$user->uid)))->field_user_mail,
                'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
            );
            return new Response(theme()->render('mail-setting-add.html',$res));       
        }
    }
    /**
     * 编辑邮箱配置
     * @route /mail/setting/edit/{id}
     * @access admin_access
     * @return string 
     */
    public static function setting_edit($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
        $user = Entity\User\User::load(entity_request(array('uid'=>$user->uid)));
        $id   = (int)$request->route->getParameter('id');            
        $res = array(
            'nownumber' => $id,
            'mail' => $user->field_user_mail[$id],
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );
        return new Response(theme()->render('mail-setting-edit.html',$res));       

    }
    /**
     * 删除邮箱配置
     * @route /mail/setting/delete/{id}
     * @access admin_access
     * @return string 
     */
    public static function setting_delete($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
        $user = Entity\User\User::load(entity_request(array('uid'=>$user->uid)));
        $id   = (int)$request->route->getParameter('id');
        $mail = $user->field_user_mail;
        unset($mail[$id]);      
        $array = array('uid'=>$user->uid,'field_user_mail'=>$mail);
        sort($array['field_user_mail']);
        Entity\User\User::update(entity_request($array));
        return new RedirectResponse($request->getUriForPath('/mail/setting'),'0',
                        'ok',array('Content-type'=>'text/html; charset=utf-8'));
    }
    
    /**
     * @ 检查邮箱可用性
     *
     */
    protected function checkEmail(&$params) {
        if(empty($params)) return true;
        foreach($params as $k=>$param) {
            $param += unserialize($param['options']);
            $sendmail = new Pyramid\Vendor\Mailer\Mailer($param);
            if($sendmail->check() == true) {
                $params[$k]['status'] = 1;
            } else {
                $params[$k]['status'] = 2;
            }
            $sendmail = null;
        }       
    }
    
    /**
     * 发送历史列表
     * @route /mail/search
     * @access admin_access
     * @param int $page
     * @param int $size
     * @param int $status
     * @return string 
     */
    public static function search($request) {
        if (($user=Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
        //conditions 
        $request->setParameter('conditions',array(
            'uid'    => array('value'=>$user->uid),
            'status' => array('value'=>$request->get('status',null)),
        ));
        $res = array(
            'list'  => Entity\Mail\Mail::search($request),
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );
        return new Response(theme()->render('mail-search.html',$res));
    }
    /**
     * 待发列表
     * @route /mail/waitting
     * @access admin_access
     * @param int $page
     * @param int $size
     * @param int $status
     * @return string 
     */
    public static function taskSearch($request) {
        if (($user=Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
        //conditions 
        $request->setParameter('conditions',array(
            'type'   => array('value'=>1),
            'uid'    => array('value'=>$user->uid),
            'status' => array('value'=>$request->get('status',null)),
        ));

        $res = array(
            'list'  => Entity\Task\Task::search($request),
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );
        
        return new Response(theme()->render('mail-task.html',$res));
    }
    
    /**
     * 邮件重发
     * @route /mail/resend
     * @access admin_access
     * @param int $id   任务ID
     * @return string 
     */
    public static function reSend($request) {
        if (($user=Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                         '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
        $id = (int)$request->get('id');
        $task = Entity\Task\Task::load(entity_request(array('id'=>$id)));
        if ($task->status==1 && (time()-$task->created) > 10) {
            db_update("task")
                ->fields(array('status'=>0,'created'=>time()))
                ->condition("id",$id)
                ->execute();
        }
        return new RedirectResponse($request->getUriForPath('/mail/waitting'),'0');  
    }
    
    /**
     * 发送邮件
     * @route /mail/send
     * @access admin_access
     * @return string 
     */
    public static function mail_send($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
        $user = Entity\User\User::load(entity_request(array('uid'=>$user->uid)));
        if ($post_data = $request->post->getParameters()) {
            $post_data += array('uid'=>$user->uid);
            $msgid = Entity\Mail\Mail::send(entity_request($post_data));
            return new Response(json_encode(
                                array('status'=>'success','msgid'=>$msgid)),'200',
                                array('Content-Type'=>'application/json'));
        }
        else {
            $res = array(
                'mails' => Entity\User\User::load(entity_request(array('uid'=>$user->uid)))->field_user_mail,
                'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
            );
            return new Response(theme()->render('mail-send.html',$res));       
        }
    }
}