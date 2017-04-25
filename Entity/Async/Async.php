<?php

/**
 * @ file
 *  
 * @ Async 异步worker
 */

namespace Entity\Async;
entity_register('async', array(
	'controller' => 'Entity\\Async\\AsyncEntityController',
    'primaryKey' => 'id',
    'baseTable'  => 'async',
));


class Async {

    //根据主键读取
    public static function load($request) {
        $id  = (int) $request->getParameter('id');
        $data = entity_load('async', array($id));
        return reset($data);
    }

    //根据主键读取多个
    public static function loadMulti($request) {
        $ids = $request->getParameter('ids');
        if ($ids && !is_array($ids)) {
            $ids = explode(',', $ids);
        }
        $data = entity_load('async', $ids);
        return $data;
    }

    //新增
    public static function insert($request) {
        $async = (object) $request->getParameters();
        unset($async->id);
        $async->created = $async->updated = time();
        entity_insert('async', $async);
        return $async;
    }
    
    //修改
    public static function update($request) {
        $async = (object) $request->getParameters();
        unset($async->created);
        entity_update('async', $async);
        return $async;
    }

    //列表
    public static function search($request) {
        $navi   = array('page'=> 1,'size' => 10, 'total'=> 0, 'pages' => 1);
        $page   = (int) $request->getParameter('page', 1);
        $size   = (int) $request->getParameter('size', 10);
        $query  = db_select('async', 'a')
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
}