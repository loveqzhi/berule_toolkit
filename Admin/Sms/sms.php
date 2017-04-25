<?php

/**
 * @ Api file sms.php
 * @ public for Back-stage management
 * @ 
 */
namespace Admin\Sms;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Entity;
use Admin;
use Pyramid;

class Sms {

    /**
     * 短信接口配置
     * @route /sms/setting
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
            'list'  => Entity\User\User::load(entity_request(array('uid'=>$user->uid)))->field_user_sms,
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );
		//更新短信接口信息
		self::checkSms($res['list']);
		$array = array(
			'uid' => $user->uid,
			'field_user_sms' => $res['list'],
		);
        Entity\User\User::update(entity_request($array));
        return new Response(theme()->render('sms-setting.html',$res));
    }
    /**
     * 新增接口配置
     * @route /sms/setting/add
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
            $key = array_keys($post_data['field_user_sms'])[0];
            $post_data['field_user_sms'][$key]['options'] = isset($post_data['field_user_sms'][$key]['options'])?
				serialize($post_data['field_user_sms'][$key]['options']) : serialize(array());
            $array = array(
                'uid' => $user->uid,
                'field_user_sms' => $post_data['field_user_sms'] + $user->field_user_sms,
            );
            ksort($array['field_user_sms']);
            //to do 获取余额信息
            self::checkSms($array['field_user_sms']);
            Entity\User\User::update(entity_request($array));
            return new Response(json_encode(
                                array('status'=>'success','msg'=>'ok')),'200',
                                array('Content-Type'=>'application/json'));
        }
        else {
            if(!empty($user->field_user_sms)) {
                $maxid = str_replace('sms','',max(array_column($user->field_user_sms,'name')));
            } else {
                $maxid = 0;
            }
            $res = array(
                'maxid' => $maxid,
                'sms'   => Entity\User\User::load(entity_request(array('uid'=>$user->uid)))->field_user_sms,
                'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
            );
            return new Response(theme()->render('sms-setting-add.html',$res));       
        }
    }
    /**
     * 编辑短信接口
     * @route /sms/setting/edit/{id}
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
            'sms' => $user->field_user_sms[$id],
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );
        return new Response(theme()->render('sms-setting-edit.html',$res));       

    }
    /**
     * 删除短信接口
     * @route /sms/setting/delete/{id}
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
        $sms = $user->field_user_sms;
        unset($sms[$id]);   
        $array = array('uid'=>$user->uid,'field_user_sms'=>$sms);
        sort($array['field_user_sms']);
        Entity\User\User::update(entity_request($array));
        return new RedirectResponse($request->getUriForPath('/sms/setting'),'0',
                        'ok',array('Content-type'=>'text/html; charset=utf-8'));
    }
    
	/**
     * @ 检查短信接口余额
     *
     */
    protected function checkSms(&$params) {
        if(empty($params)) return true;
        foreach($params as $k=>$param) {
			$response = curl("http://218.244.141.161:8888/sms.aspx",array(),array(
					'userid'   => $param['userid'],
					'account'  => $param['account'],
					'password' => $param['password'],
					'action'   => 'overage',
			));
			logger()->debug("result:".$response[1]);
			$status  = self::getPregString($response[1],'<returnstatus>','</returnstatus>');
			$overage = self::getPregString($response[1],'<overage>','</overage>');
			$options = unserialize($params[$k]['options']);
			if ($options == null) {
				$options = array();
			}
            if(($status == 'Sucess' || $status == 'Success') && !empty($overage)) {
                $params[$k]['status'] = 1;				
				$params[$k]['options'] = serialize(array('overage'=>$overage) + $options);
            } else {
                $params[$k]['status'] = 2;
				$params[$k]['options'] = serialize(array('overage'=>0) + $options);
            }
			logger()->debug("status:".$status." overage:".$overage);
            $status = $overage = $response = $options = null;
        }       
    }

    //切割xml字符
	public static function getPregString($string,$l,$r) {
		$str1 = explode($l,$string);
		return explode($r,$str1[1])[0];
	}
    
    /**
     * 发送历史列表
     * @route /sms/search
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
        $request->setParameter('conditions', array(
            'uid'    => array('value' => $user->uid),
            'status' => array('value' => $request->get('status',null)), 
        ));
        $res = array(
            'list'  => Entity\Sms\Sms::search($request),
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );
        return new Response(theme()->render('sms-search.html',$res));
    }
    /**
     * 待发列表
     * @route /sms/waitting
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
        $request->setParameter('conditions', array(
            'type'   => array('value' => '2'),
            'uid'    => array('value' => $user->uid),
            'status' => array('value' => $request->get('status',null)), 
        ));
        $res = array(
            'list'  => Entity\Task\Task::search($request),
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );

        return new Response(theme()->render('sms-task.html',$res));
    }
    
    /**
     * 短信重发
     * @route /sms/resend
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
        return new RedirectResponse($request->getUriForPath('/sms/waitting'),'0');  
    }
    /**
     * 发送短信
     * @route /sms/send
     * @access admin_access
     * @return string 
     */
    public static function sms_send($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
        $user = Entity\User\User::load(entity_request(array('uid'=>$user->uid)));
        if ($post_data = $request->post->getParameters()) {
            $post_data += array('uid'=>$user->uid);
            $msgid = Entity\Sms\Sms::send(entity_request($post_data));
            return new Response(json_encode(
                                array('status'=>'success','msgid'=>$msgid)),'200',
                                array('Content-Type'=>'application/json'));
        }
        else {
            $res = array(
                'sms' => Entity\User\User::load(entity_request(array('uid'=>$user->uid)))->field_user_sms,
                'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
            );
            return new Response(theme()->render('sms-send.html',$res));       
        }
    }
}
