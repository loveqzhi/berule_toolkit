<?php

/**
 * @ file
 *  
 * @ Application 用户app认证中心
 */

namespace Entity\Application;
entity_register('application', array(
	'controller' => 'Entity\\Application\\AppEntityController',
    'primaryKey' => 'id',
    'baseTable'  => 'application',
));


class Application {

    //根据主键读取
    public static function load($request) {
        $id  = (int) $request->getParameter('id');
        $data = entity_load('application', array($id));
        return reset($data);
    }

    //根据主键读取多个
    public static function loadMulti($request) {
        $ids = $request->getParameter('ids');
        if ($ids && !is_array($ids)) {
            $ids = explode(',', $ids);
        }
        $data = entity_load('application', $ids);
        return $data;
    }

    //appid
    public static function loadByAppid($request) {
        $appid = $request->getParameter('appid');
        $data  = entity_load('application', array(), array('appid'=>$appid));
        return reset($data);
    }

    //新增
    public static function insert($request) {
        $application = (object) $request->getParameters();
        unset($application->id);
        $application->created = $application->updated = time();
        entity_insert('application', $application);
        return $application;
    }
    
    //修改
    public static function update($request) {
        $application = (object) $request->getParameters();
        unset($application->created);
        entity_update('application', $application);
        return $application;
    }

    //列表
    public static function search($request) {
        $navi   = array('page'=> 1,'size' => 10, 'total'=> 0, 'pages' => 1);
        $page   = (int) $request->getParameter('page', 1);
        $size   = (int) $request->getParameter('size', 10);
        $query  = db_select('application', 'a')
                        ->extend('Pager')->page($page)->size($size)
                        ->fields('a', array('id'));
        foreach ($request->getParameter('conditions',array()) as $key=>$val) {
            $flag = isset($val['flag'])? $val['flag'] : '=';
            if (!is_null($val['value'])) {
                $query->condition($key,$val['value'],$flag);
            }
        }
        foreach($request->getParameter('leftJoin',array()) as $tb=>$val) {
            $query->leftJoin($tb,$tb,$tb.".entity_id=c.id");
            foreach ($val as $kk=>$vv) {
                $flag = isset($vv['flag'])? $vv['flag'] : '=';
                if (!is_null($vv['value'])) {
                    $query->condition($tb.".".$kk,$vv['value'],$flag);
                }
            }
        }
        foreach ($request->getParameter('orderBys',array()) as $key=>$val) {
            if (!is_null($val['value'])) {
                $query->orderBy($key,$val['value']);
            }
        }
        $query->orderBy('id','DESC');
        $ids     = $query->execute()->fetchCol();
        $pager   = array_merge($navi,$query->fetchPager());
        $data    = self::loadMulti(entity_request(array('ids'=>$ids)));
        return array('data'=>$data, 'pager'=>$pager);
    }
    
    // check user register 
	public static function check($uid,$type) {
		return db_select("application","a")
				->fields("a",array("id"))
				->condition("a.uid",$uid)
				->condition("a.type",$type)
				->execute()
				->fetchField();
	}
    //appid
    public static function createAppid($uid) {
        list($usec, $sec) = explode(' ', microtime());
        return 'bl'.strtoupper(substr(md5($uid),0,2)) . date('YmdHis', $sec) . (int) ($usec * 1000000);
    }
    //uid
    public static function getUidByAppid($appid) {
        $application = self::loadByAppid(entity_request(array('appid'=>$appid)));
        return !empty($application)? $application->uid : null;
    }
}