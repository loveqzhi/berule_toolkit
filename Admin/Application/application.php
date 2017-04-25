<?php

/**
 * @ Admin file application.php
 * @ 
 */
namespace Admin\Application;

use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Entity;

class Application {

    /**
     * 申请应用
     * @route /application/add
     * @access admin_access
     * @return string 
     */
    public static function add($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
		$user = Entity\User\User::load(entity_request(array('uid'=>$user->uid)));
        if ($post_data = $request->post->getParameters()) {
			if(empty($post_data['name']) || empty($post_data['name']) || empty($post_data['name'])) {
				return new Response(json_encode(
                                array('status'=>'error','msg'=>'名称|邮箱|电话 必须填写')),'200',
                                array('Content-Type'=>'application/json'));
			}
			$is_has = Entity\Application\Application::check($user->uid,$post_data['type']);
			if($is_has) {
				return new Response(json_encode(
                                array('status'=>'error','msg'=>'目前只开放一次申请')),'200',
                                array('Content-Type'=>'application/json'));
			}
			$post_data['uid'] = $user->uid;
            Entity\Application\Application::insert(entity_request($post_data));
            return new Response(json_encode(
                                array('status'=>'success','msg'=>'ok')),'200',
                                array('Content-Type'=>'application/json'));
        }
        else {
			$res = array(
				'type' => $request->get('type',1),
				'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
			);
			return new Response(theme()->render('application-add.html',$res));
		}
    }
    
	/**
     * 编辑应用
     * @route /application/edit/{id}
     * @access admin_access
     * @return string 
     */
    public static function edit($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
        $id   = (int)$request->route->getParameter('id');            
        $res = array(
            'application' => Entity\Application\Application::load(entity_request(array('id'=>$id))),
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );
		if($res['application']->uid != $user->uid) {
			return new RedirectResponse($request->getUriForPath('/application/search'),'2',
                        '非法操作',array('Content-type'=>'text/html; charset=utf-8'));
		}
        return new Response(theme()->render('application-edit.html',$res));       

    }
	/**
     * 审核应用
     * @route /application/verify/edit/{id}
     * @access admin_access
     * @return string 
     */
    public static function verify_edit($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
		if ($user->uid != 1) {
            return new RedirectResponse($request->getUriForPath('/application/search'),'2',
                        '非法操作',array('Content-type'=>'text/html; charset=utf-8'));
        }
        $id   = (int)$request->route->getParameter('id');            
        $res = array(
            'application' => Entity\Application\Application::load(entity_request(array('id'=>$id))),
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );
        return new Response(theme()->render('application-verify-edit.html',$res));       

    }
	
	/**
     * 更新应用
     * @route /application/update
     * @access admin_access
     * @return string 
     */
    public static function update($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
		$post_data = $request->getParameters();
        if (!empty($post_data['id'])) {
            $application = Entity\Application\Application::load(entity_request(array('id'=>$post_data['id'])));
			if($application->uid != $user->uid) {
				return new RedirectResponse($request->getUriForPath('/application/search'),'2',
							'非法操作',array('Content-type'=>'text/html; charset=utf-8'));
			}
			if(empty($post_data['name']) || empty($post_data['name']) || empty($post_data['name'])) {
				return new Response(json_encode(
                                array('status'=>'error','msg'=>'名称|邮箱|电话 必须填写')),'200',
                                array('Content-Type'=>'application/json'));
			}
			if($application->status==0 || $application->status==4) {
				$post_data['status'] = 0;
			}
			Entity\Application\Application::update(entity_request($post_data));
			return new Response(json_encode(
                                array('status'=>'success','msg'=>'ok')),'200',
                                array('Content-Type'=>'application/json'));
        }
		else {
			return new RedirectResponse($request->getUriForPath('/application/search'),'2',
						'非法操作',array('Content-type'=>'text/html; charset=utf-8'));
		}     
    }
	
	/**
     * 更新审核应用
     * @route /application/verify/update
     * @access admin_access
     * @return string 
     */
    public static function verify_update($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
		if ($user->uid != 1) {
            return new RedirectResponse($request->getUriForPath('/application/search'),'2',
                        '非法操作',array('Content-type'=>'text/html; charset=utf-8'));
        }
		$post_data = $request->getParameters();
        if (!empty($post_data['id'])) {
			$application = Entity\Application\Application::load(entity_request(array('id'=>$post_data['id'])));
			if(empty($application->appid) && $post_data['status']==1) {
				//生产app_id
				$post_data['appid'] = Entity\Application\Application::createAppid($application->uid);
				$post_data['secret'] = pyramid_password_hash($post_data['app_id']);
			}
			Entity\Application\Application::update(entity_request($post_data));
			return new Response(json_encode(
                                array('status'=>'success','msg'=>'ok')),'200',
                                array('Content-Type'=>'application/json'));
			
		}
		else {
			return new RedirectResponse($request->getUriForPath('/application/search'),'2',
						'非法操作',array('Content-type'=>'text/html; charset=utf-8'));
		}
		
	}
	
    /**
     * 我的应用列表
     * @route /application/search
     * @access admin_access
     * @param int $status   状态
     * @param int $page     当前页
     * @param int $size     每页数量
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
            'list'  => Entity\Application\Application::search($request),
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );
        //print_r($res['list']);exit;
        return new Response(theme()->render('application-search.html',$res));
    }
	
	/**
     * 应用审核
     * @route /application/verify
     * @access admin_access
     * @param int $page
     * @param int $size
     * @return string 
     */
    public static function verify($request) {
        if (($user=Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
		if ($user->uid != 1) {
            return new RedirectResponse($request->getUriForPath('/application/search'),'2',
                        '非法操作',array('Content-type'=>'text/html; charset=utf-8'));
        }
        //conditions
        $request->setParameter('conditions', array(
            'status' => array('value'=>$request->get('status',0)),
        ));
        $res = array(
            'list'  => Entity\Application\Application::search($request),
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );
        return new Response(theme()->render('application-verify.html',$res));
    }

}