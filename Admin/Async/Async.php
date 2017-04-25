<?php

/**
 * @ Admin file Async.php
 * @ update 20150317
 */
namespace Admin\Async;
use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Entity;

class Async{

    /**
     * 注册worker列表
     * @route /async/search
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
            'status' => array('value'=>$request->get('status',null)),
        ));
        $res = array(
            'list'  => Entity\Async\Async::search($request),
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );
        foreach($res['list']['data'] as $k=>$data) {
            $sh = 'ps xau | grep "'.$data->file_name.' '.$data->id.'"| grep -v grep | awk \'{print $2}\' ';
            exec($sh,$pids);            
            if(!empty($pids)) {
                $index = "swoole_".$data->id;
                $res['list']['data'][$k]->pids = $pids;
                $res['list']['data'][$k]->master_pid = variable()->get($index)['master_pid'];
                $res['list']['data'][$k]->manager_pid = variable()->get($index)['manager_pid'];
                $res['list']['data'][$k]->is_runing = true;
            }
            $pids = $sh = $index = null;
        }

        return new Response(theme()->render('async-search.html',$res));
    }
    
    /**
     * 添加脚本服务
     * @route /async/add
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
            $post_data['type'] = 2;
            foreach($user->roles as $role) {
                if ($role['rid'] == 1) {
                    $post_data['type'] = 1;
                }
            }
            if(empty($post_data['name'])) {
				return new Response(json_encode(
                                array('status'=>'error','msg'=>'服务名必须填写')),'200',
                                array('Content-Type'=>'application/json'));
			}
			if(empty($post_data['file_name'])) {
				return new Response(json_encode(
                                array('status'=>'error','msg'=>'脚本文件名必须填写')),'200',
                                array('Content-Type'=>'application/json'));
			}           
            if (!file_exists(__DIR__ . '/worker/' . $post_data['file_name'])) {
                return new Response(json_encode(
                                array('status'=>'error','msg'=>'脚本不存在')),'200',
                                array('Content-Type'=>'application/json'));
            }
            if(empty($post_data['work_port'])) {
				return new Response(json_encode(
                                array('status'=>'error','msg'=>'端口必须填写')),'200',
                                array('Content-Type'=>'application/json'));
			}          
            $has_port = db_select("async","a")
                        ->fields("a",array("id"))
                        ->condition("work_port",$post_data['work_port'])
                        ->execute()
                        ->fetch();
			if($has_port) {
				return new Response(json_encode(
                                array('status'=>'error','msg'=>'端口已被使用，请重新填写')),'200',
                                array('Content-Type'=>'application/json'));
			}
            if(empty($post_data['log_file'])) {
				return new Response(json_encode(
                                array('status'=>'error','msg'=>'日志文件必须填写')),'200',
                                array('Content-Type'=>'application/json'));
			}
			$post_data['uid'] = $user->uid;
            Entity\Async\Async::insert(entity_request($post_data));
            return new Response(json_encode(
                                array('status'=>'success','msg'=>'ok')),'200',
                                array('Content-Type'=>'application/json'));
        }
        else {
			$res = array(
				'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
			);
			return new Response(theme()->render('async-add.html',$res));
		}
    }
    
    /**
     * 编辑应用
     * @route /async/edit/{id}
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
            'async' => Entity\Async\Async::load(entity_request(array('id'=>$id))),
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
        );
		if($res['async']->uid != $user->uid) {
			return new RedirectResponse($request->getUriForPath('/async/search'),'2',
                        '非法操作',array('Content-type'=>'text/html; charset=utf-8'));
		}
        return new Response(theme()->render('async-edit.html',$res));       

    }
    
     /**
     * 更新脚本服务
     * @route /async/update
     * @access admin_access
     * @return string 
     */
    public static function update($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
		$user = Entity\User\User::load(entity_request(array('uid'=>$user->uid)));
        
        if ($post_data = $request->post->getParameters()) {
            $post_data['type'] = 2;
            foreach($user->roles as $role) {
                if ($role['rid'] == 1) {
                    $post_data['type'] = 1;
                }
            }
            if(empty($post_data['name'])) {
				return new Response(json_encode(
                                array('status'=>'error','msg'=>'服务名必须填写')),'200',
                                array('Content-Type'=>'application/json'));
			}
			if(empty($post_data['file_name'])) {
				return new Response(json_encode(
                                array('status'=>'error','msg'=>'脚本文件名必须填写')),'200',
                                array('Content-Type'=>'application/json'));
			}           
            if (!file_exists(__DIR__ . '/worker/' . $post_data['file_name'])) {
                return new Response(json_encode(
                                array('status'=>'error','msg'=>'脚本不存在')),'200',
                                array('Content-Type'=>'application/json'));
            }
            if(empty($post_data['work_port'])) {
				return new Response(json_encode(
                                array('status'=>'error','msg'=>'端口必须填写')),'200',
                                array('Content-Type'=>'application/json'));
			}          
            $has_port = db_select("async","a")
                        ->fields("a",array("id"))
                        ->condition("work_port",$post_data['work_port'])
                        ->condition("id",$post_data['id'],"<>")
                        ->execute()
                        ->fetch();
			if($has_port) {
				return new Response(json_encode(
                                array('status'=>'error','msg'=>'端口已被使用，请重新填写')),'200',
                                array('Content-Type'=>'application/json'));
			}
            if(empty($post_data['log_file'])) {
				return new Response(json_encode(
                                array('status'=>'error','msg'=>'日志文件必须填写')),'200',
                                array('Content-Type'=>'application/json'));
			}
			$post_data['uid'] = $user->uid;
            Entity\Async\Async::update(entity_request($post_data));
            return new Response(json_encode(
                                array('status'=>'success','msg'=>'ok')),'200',
                                array('Content-Type'=>'application/json'));
        }
        else {
            return new Response(json_encode(
                                array('status'=>'error','msg'=>'请正确提交数据')),'200',
                                array('Content-Type'=>'application/json'));
        }

    }
    
    
    /**
     * 启动worker
     * @route /async/work/runing/{id}
     * @ return array
     */
    public static function work_runing($request) {
        if (($user = Entity\User\User::checkLogin()) == null) {
            return new RedirectResponse($request->getUriForPath('/user/login'),'2',
                        '请先登录系统',array('Content-type'=>'text/html; charset=utf-8'));
        }
		$user = Entity\User\User::load(entity_request(array('uid'=>$user->uid)));
        $id   = trim($request->route->getParameter('id')); 
        $async = db_select("async","a")
                    ->fields("a")
                    ->condition("id",$id)
                    ->execute()
                    ->fetch();
                   
        if(!empty($async) && $async->uid == $user->uid) {
            posix_setuid(99);
            posix_setgid(99);
            $commod = "nohup php ". __DIR__ . "/worker/" . $async->file_name ." ".$id." >> ".$async->log_file." 2>&1 &";            
            exec($commod);
            return new RedirectResponse($request->getUriForPath('/async/search'),'2',
                        '启动成功',array('Content-type'=>'text/html; charset=utf-8'));
        }
        else {
            return new RedirectResponse($request->getUriForPath('/async/search'),'2',
                        '非法启动',array('Content-type'=>'text/html; charset=utf-8'));  
        }
    }
    
     /**
     * 杀死进程
     * @route /async/work/kill/{pid}
     * @ return array
     */
    public static function work_kill($request) {
        $pid   = $request->route->getParameter('pid'); 
        $pids = explode(",",$pid);
        foreach($pids as $p) {
            exec("kill -9 ".$p);
        }
        return new RedirectResponse($request->getUriForPath('/async/search'),'2',
                        '关闭worker成功',array('Content-type'=>'text/html; charset=utf-8'));
    }
    
}