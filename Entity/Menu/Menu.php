<?php 

/**
 * @ file menu
 * @ 返回用户可见权限菜单
 * @ return authentication menu
 */
namespace Entity\Menu;
use Entity;

class Menu { 
    /**
     * 获取菜单
     * @route
     * @access 
     * @param 
     * @return array 
     */
    public static function getMenu($route) {
        $path = '/' . $route;
        $menus = self::setMenus();
        $admin = Entity\User\User::load(entity_request(array('uid'=>session()->get('user')->uid)));
        foreach ($menus as $k=>$v) {
            //if(strpos($path,$v['href'])!==false) {
            if(strpos($path,dirname($v['href'])) === 0) {
                $menus[$k]['active'] = true;
            }
            foreach($v['childs'] as $kk => $vv) {
                if (!isset($admin->permissions[$vv['href']])) {
                    unset($menus[$k]['childs'][$kk]);
                }
            }
            
            if (empty($menus[$k]['childs']))
                unset($menus[$k]);

        }
        //print_r($menus);exit;
        foreach ($menus as $k => $v) {
			if($v['active'] == true) {
				foreach ($v['childs'] as $kk => $vv) {
					if ($vv['href'] == $path || strpos($path,$vv['href'])!==false) {
						$menus[$k]['childs'][$kk]['active'] = true;						
					}
				}
                return array($menus, $menus[$k]);
			}
        }
        $route = dirname($route);
        if ($route == '.' || $route == '/' || $route == '\\') {
            return array($menus, array());
        } else {
            return self::getMenu($route);
        }
    }
    /**
     * 设置路由
     * @route 
     * @access 
     * @param 
     * @return array 
     */
    public static function setMenus(){
        return array(
                '1'  => array(
                    'name'   => '邮件服务',
                    'href'   => '/mail/search',
                    'icon'   => 'fa-envelope',
                    'active' => false,
                    'childs' => array(
                        array(
                            'name'   => '发送历史',
                            'href'   => '/mail/search',
                            'icon'   => 'fa-film',
                            'active' => false,
                        ),
                        array(
                            'name'   => '写邮件',
                            'href'   => '/mail/send',
                            'icon'   => 'fa-pencil',
                            'active' => false,
                        ),
						array(
                            'name'   => '待发列表',
                            'href'   => '/mail/waitting',
                            'icon'   => 'fa-history',
                            'active' => false,
                        ),
                        array(
                            'name'   => '邮箱配置',
                            'href'   => '/mail/setting',
                            'icon'   => 'fa-gear',
                            'active' => false,
                        ),
                        
					),
                ),
                '2'  => array(
                    'name'   => '短信服务',
                    'href'   => '/sms/search',
                    'icon'   => 'fa-rss',
                    'active' => false,
                    'childs' => array(
                        array(
                            'name'   => '已发短信',
                            'href'   => '/sms/search',
                            'icon'   => 'fa-film',
                            'active' => false,
                        ),
                        array(
                            'name'   => '发短信',
                            'href'   => '/sms/send',
                            'icon'   => 'fa-envelope-o',
                            'active' => false,
                        ),
						array(
                            'name'   => '待发列表',
                            'href'   => '/sms/waitting',
                            'icon'   => 'fa-history',
                            'active' => false,
                        ),
                        array(
                            'name'   => '短信接口',
                            'href'   => '/sms/setting',
                            'icon'   => 'fa-gear',
                            'active' => false,
                        ),
                        
					),
                ),
                '3'  => array(
                    'name'   => '数据抓取',
                    'href'   => '/spider/search',
                    'icon'   => 'fa-database',
                    'active' => false,
                    'childs' => array(
                        array(
                            'name'   => '数据列表',
                            'href'   => '/spider/search',
                            'icon'   => 'fa-film',
                            'active' => false,
                        ),
                        array(
                            'name'   => '抓取配置',
                            'href'   => '/spider/setting',
                            'icon'   => 'fa-gear',
                            'active' => false,
                        ),
                        
					),
                ),
                '4'  => array(
                    'name'   => '消息推送',
                    'href'   => '/message/search',
                    'icon'   => 'fa-comments',
                    'active' => false,
                    'childs' => array(
                        array(
                            'name'   => '消息列表',
                            'href'   => '/message/search',
                            'icon'   => 'fa-film',
                            'active' => false,
                        ),
                        
					),
                ),
				'5'  => array(
                    'name'   => '我的应用',
                    'href'   => '/application/search',
                    'icon'   => 'fa-magnet',
                    'active' => false,
                    'childs' => array(
                        array(
                            'name'   => '应用列表',
                            'href'   => '/application/search',
                            'icon'   => 'fa-film',
                            'active' => false,
                        ),
						array(
                            'name'   => '审核应用',
                            'href'   => '/application/verify',
                            'icon'   => 'fa-film',
                            'active' => false,
                        ),
						array(
                            'name'   => '开发者',
                            'href'   => '/application/interface',
                            'icon'   => 'fa-gear',
                            'active' => false,
                        ),
                        
					),
                ),
                /*
				'6'  => array(
                    'name'   => '计划任务',
                    'href'   => '/cron/task',
                    'icon'   => 'fa-tasks',
                    'active' => false,
                    'childs' => array(
                        array(
                            'name'   => '脚本任务',
                            'href'   => '/cron/task',
                            'icon'   => 'fa-compass',
                            'active' => false,
                        ),
						array(
                            'name'   => 'worker',
                            'href'   => '/cron/work',
                            'icon'   => 'fa-gear',
                            'active' => false,
                        ),
                        
					),
                ),
                */
                '7'  => array(
                    'name'   => '计划任务',
                    'href'   => '/async/search',
                    'icon'   => 'fa-tasks',
                    'active' => false,
                    'childs' => array(
                        array(
                            'name'   => 'Worker管理',
                            'href'   => '/async/search',
                            'icon'   => 'fa-compass',
                            'active' => false,
                        ),
                        
					),
                ),
                '8'  => array(
                    'name'   => '微信企业号',
                    'href'   => '/wechat/user',
                    'icon'   => 'fa-weixin',
                    'active' => false,
                    'childs' => array(
                        array(
                            'name'   => '员工管理',
                            'href'   => '/wechat/user',
                            'icon'   => 'fa-user',
                            'active' => false,
                        ),
                        array(
                            'name'   => '账号配置',
                            'href'   => '/wechat/setting',
                            'icon'   => 'fa-gear',
                            'active' => false,
                        ),
                        
					),
                ),
                '98' => array(
                    'name'   => '客户管理',
                    'href'   => '/user/search',
                    'icon'   => 'fa-users',
                    'active' => false,
                    'childs' => array(
                        array(
                            'name'   => '用户列表',
                            'href'   => '/user/search',
                            'icon'   => 'fa-user',
                            'active' => false,
                        ),
						array(
                            'name'   => '新增用户',
                            'href'   => '/user/add',
                            'icon'   => 'fa-pencil',
                            'active' => false,
                        ),
					),
				),
                '99' => array(
                    'name'   => '角色管理',
                    'href'   => '/admin/role/search',
                    'icon'   => 'fa-wrench',
                    'active' => false,
                    'childs' => array(                       
                        array(
                            'name'   => '角色列表',
                            'href'   => '/admin/role/search',
                            'icon'   => 'fa-reorder',
                            'active' => false,
                        ),
						array(
                            'name'   => '添加角色',
                            'href'   => '/admin/role/add',
                            'icon'   => 'fa-pencil',
                            'active' => false,
                        ),
                    ),
                ),
        
        );
    }
}