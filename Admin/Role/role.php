<?php
namespace Admin\Role;
use Pyramid\Component\HttpFoundation\Response;
use Pyramid\Component\HttpFoundation\RedirectResponse;
use Entity;

class Role {

    /**
     * 返回权限配置数组
     * @route 
     * @access
     * @param 
     * @return array
     */
    protected static function getPermissions(){
        return  array(
            '微信企业号' => array(
				'/wechat/user' => array(
                        'title'         => '用户管理',
                        'description'   => '更新地区',
                        'module'        => 'wechat',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
                '/wechat/setting' => array(
                        'title'         => '账号配置',
                        'description'   => '',
                        'module'        => 'wechat',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
			),
            '邮件服务' => array(                
                '/mail/search' => array(
                        'title'         => '发送历史',
                        'description'   => '列表',
                        'module'        => 'mail',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
				'/mail/send' => array(
                        'title'         => '写邮件',
                        'description'   => '',
                        'module'        => 'mail',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
				'/mail/waitting' => array(
                        'title'         => '待发列表',
                        'description'   => '',
                        'module'        => 'mail',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
                '/mail/setting' => array(
                        'title'         => '邮箱配置',
                        'description'   => '',
                        'module'        => 'mail',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
            ),
            '短信服务' => array(                
                '/sms/search' => array(
                        'title'         => '已发短信',
                        'description'   => '列表',
                        'module'        => 'sms',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
				'/sms/send' => array(
                        'title'         => '发短信',
                        'description'   => '',
                        'module'        => 'sms',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
				'/sms/waitting' => array(
                        'title'         => '待发列表',
                        'description'   => '',
                        'module'        => 'sms',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
                '/sms/setting' => array(
                        'title'         => '短信接口',
                        'description'   => '',
                        'module'        => 'sms',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
            ),
			'我的应用' => array(                
                '/application/search' => array(
                        'title'         => '应用列表',
                        'description'   => '列表',
                        'module'        => 'application',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
			    '/application/verify' => array(
                        'title'         => '审核应用',
                        'description'   => '审核应用',
                        'module'        => 'application',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
				'/application/add' => array(
                        'title'         => '申请应用',
                        'description'   => '申请应用',
                        'module'        => 'application',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
			    '/application/interface' => array(
                        'title'         => '开发者',
                        'description'   => '开发者',
                        'module'        => 'application',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
            ),
            '计划任务' => array(
				'/async/search' => array(
                        'title'         => 'Worker管理',
                        'description'   => 'Worker管理',
                        'module'        => 'async',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
			),
            /*
			'计划任务' => array(
				'/cron/task' => array(
                        'title'         => '定时脚本',
                        'description'   => '定时脚本',
                        'module'        => 'cron',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
			   '/cron/task/runing' => array(
                        'title'         => '脚本启动',
                        'description'   => '脚本启动',
                        'module'        => 'cron',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
				'/cron/work' => array(
                        'title'         => '工作Worker',
                        'description'   => '工作Worker',
                        'module'        => 'cron',
                        'quantity'      => '2',
                        'inherited'     => '',
                        'warning'       => '',
                ),
			),
            */
			'客户管理' => array(
				'/user/search' => array(
                        'title'         => '用户列表',
                        'description'   => '更新地区',
                        'module'        => 'user',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
				'/user/add' => array(
                        'title'         => '添加用户',
                        'description'   => '添加用户',
                        'module'        => 'user',
                        'quantity'      => '2',
                        'inherited'     => '',
                        'warning'       => '',
                ),
				'/user/edit' => array(
                        'title'         => '编辑用户',
                        'description'   => '编辑用户',
                        'module'        => 'user',
                        'quantity'      => '3',
                        'inherited'     => '',
                        'warning'       => '',
                ),
			),
            '角色管理' => array(                
                '/admin/role/search' => array(
                        'title'         => '角色列表',
                        'description'   => '更新角色',
                        'module'        => 'role',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
				'/admin/role/add' => array(
                        'title'         => '添加角色',
                        'description'   => '更新角色',
                        'module'        => 'role',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
				'/admin/role/edit' => array(
                        'title'         => '编辑角色',
                        'description'   => '更新角色',
                        'module'        => 'role',
                        'quantity'      => '1',
                        'inherited'     => '',
                        'warning'       => '',
                ),
            ),
        );
    }
    
    
    /**
     * 获取扁平化权限数组
     * @route 
     * @access 
     * @return array
     */
    public static function getAllPermissions() {
        $tempPermissions = array();
		foreach (self::getPermissions() as $v) {
			$tempPermissions = array_merge($tempPermissions,$v);
		}
        return $tempPermissions;
    }
    
    /**
     * 更新用户角色
     * @route
     * @access
     * @param $param 角色ID数组
     * @param $id   用户ID
     * @return boolean
     */
    public static function updateUserRoleByUid($param,$uid) {
        //删除原角色
        $thisdb = db_transaction(); //开启事务
        try {
            db_delete("relation_user_roles")
                ->condition("uid",$uid)
                ->execute();
            foreach($param as $v) {
                db_insert("relation_user_roles")
                    ->fields(array('uid'=>$uid,'rid'=>$v))
                    ->execute();
            }
        } catch (Exception $e) {
            $thisdb->rollback(); //回滚
            logger()->warn("更新用户角色失败了: ".$e->getMessage());
        }
        
        return true;
    }
    
    /**
     * 角色列表
     * @route /admin/role/search
     * @param int $page
     * @param int $size
     * @ return array
     */
    public static function search($request) {
        
        $res = array(
            'menus' => Entity\Menu\Menu::getMenu($request->route->get('path'))[0],
            'list'  => Entity\Role\Role::search($request),
        );
		
        return new Response(theme()->render('admin-role.html',$res));  
    }
    
    /**
     * 添加角色权限
     * @route /admin/role/add
     * @param $request
     * @return mixed
     */
    public static function add ($request) {
        //判断权限 todo
                
        $temproles = self::getAllPermissions();       
        if ($request->post->getParameters()) {
            $post_data = $request->getParameters();
            if (empty($post_data['name'])) {
                return new Response(json_encode(
                                array('status'=>'error','msg'=>'角色名称必须填写')),'200',
                                array('Content-Type'=>'application/json'));
            }
            if (!empty($post_data['field_role_permission'])) {
                foreach ($post_data['field_role_permission'] as $k => $v) {
                    if (isset($temproles[$v])) {
                        $post_data['field_role_permission'][$k] = array('permission'=>$v,'data'=>serialize($temproles[$v]));
                    } else {
                        unset($post_data['field_role_permission'][$k]);
                    }
                }
            }
            Entity\Role\Role::insert(entity_request($post_data));
            return new Response(json_encode(
                                array('status'=>'success','msg'=>'ok')),'200',
                                array('Content-Type'=>'application/json'));
        }
        else {
            $res['temproles'] = self::getPermissions();
            $res['menus'] = Entity\Menu\Menu::getMenu($request->route->get('path'))[0]; 
            return new Response(theme()->render('admin-role-add.html',$res));
        }
    }
    /**
     * 编辑角色权限
	 * @route /admin/role/edit/{rid}
	 * @access
	 * @param $request 
	 * @return redirect
	 */
	public static function edit($request) {
        //判断权限 todo
        
        $rid = (int)$request->route->getParameter('rid');
        $res['role'] = Entity\Role\Role::load(entity_request(array('rid'=>$rid)));
        if (empty($res['role'])) {
            return new RedirectResponse($request->getUriForPath('/admin/role/search'),'2',
                        lang('非法操作'),array('Content-type'=>'text/html; charset=utf-8'));
        }
        //print_r($res['role']);exit;
        $res['temproles'] = self::getPermissions();
        $res['menus'] = Entity\Menu\Menu::getMenu($request->route->get('path'))[0];
        return new Response(theme()->render('admin-role-edit.html',$res));
    
    }
    
    /**
     * 更新角色权限
	 * @route /admin/role/update
	 * @access
	 * @param $request 
	 * @return redirect
	 */
	public static function update($request) {
		$tempPerms = self::getAllPermissions();
		$post_data = $request->getParameters();
		if (!empty($post_data['rid'])) {
			$array['rid'] = (int) $post_data['rid'];
            $array['name'] = trim($post_data['name']);
            $array['weight'] = (int)$post_data['weight'];
			foreach ($post_data['field_role_permission'] as $key) {
				if (isset($tempPerms[$key])) {
					$array['field_role_permission'][] = array('permission'=>$key,'data'=>serialize($tempPerms[$key]));
				}
			}
			Entity\Role\Role::update(entity_request($array));
            return new Response(json_encode(
                                array('status'=>'success','msg'=>'ok')),'200',
                                array('Content-Type'=>'application/json'));
		}
        else {
            return new Response(json_encode(
                                array('status'=>'error','msg'=>lang('非法操作'))),'200',
                                array('Content-Type'=>'application/json'));
        }

	}
    
}