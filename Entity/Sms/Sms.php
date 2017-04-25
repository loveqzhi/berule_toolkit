<?php

/**
 * @ file
 *  
 * @ Sms 短信服务
 */

namespace Entity\Sms;
use Entity;
use PDO;
entity_register('sms', array(
    'primaryKey' => 'id',
    'baseTable'  => 'sms',
));


class Sms {

    //根据主键读取
    public static function load($request) {
        $id  = (int) $request->getParameter('id');
        $data = entity_load('sms', array($id));
        return reset($data);
    }

    //根据主键读取多个
    public static function loadMulti($request) {
        $ids = $request->getParameter('ids');
        if ($ids && !is_array($ids)) {
            $ids = explode(',', $ids);
        }
        $data = entity_load('sms', $ids);
        return $data;
    }

    //msgid
    public static function loadByMsgid($request) {
        $msgid = $request->getParameter('msgid');
        $data  = entity_load('sms', array(), array('msgid'=>$msgid));
        return reset($data);
    }

    //新增
    public static function insert($request) {
        $sms = (object) $request->getParameters();
        unset($sms->id);
        $sms->updated = time();
        entity_insert('sms', $sms);
        //logger()->info("save a e-mail success: ".var_export((array)$mail,true));
        return $sms;
    }
    
    //修改
    public static function update($request) {
        $sms = (object) $request->getParameters();
        unset($sms->created);
        entity_update('sms', $sms);
        return $sms;
    }

    //发送列表
    public static function search($request) {
        $navi   = array('page'=> 1,'size' => 10, 'total'=> 0, 'pages' => 1);
        $page   = (int) $request->getParameter('page', 1);
        $size   = (int) $request->getParameter('size', 10);
        $query  = db_select('sms', 'm')
                        ->extend('Pager')->page($page)->size($size)
                        ->fields('m', array('id'));
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
        $query->orderBy('id', 'DESC');
        $ids     = $query->execute()->fetchCol();
        $pager   = array_merge($navi,$query->fetchPager());
        $data    = self::loadMulti(entity_request(array('ids'=>$ids)));
        return array('data'=>$data, 'pager'=>$pager);
    }
    
    /**
     * 站内短信发送
     * @param  int    $boxid    使用的邮箱接口ID
     * @param  int    $uid      用户UID
     * @param  string $phone    发送手机号
     * @param  string $content  内容
     */
    public static function send($request){
        $uid = $request->getParameter('uid',null);
        $boxid = $request->getParameter('boxid',null);
        $config = Entity\User\User::getUserSmsOption($uid,$boxid);
        $data = array(
            'phone'		=> $request->getParameter('phone'),
            'content'   => '【'.$config['sign'].'】'.$request->getParameter('content'),
        );
        $array = array(
            'type'      => 2,
            'uid'       => $uid,
            'msgid'     => self::getMsgId($uid),
            'channel'   => $config['name'],
            'data'      => serialize(array('config'=>$config,'data'=>$data)),
            'status'    => 0,
            'created'   => time(),
        );
        db_insert("task")->fields($array)->execute();
        return $array['msgid'];
    }
    
    //msgid
    public static function getMsgId($uid) {
        list($usec, $sec) = explode(' ', microtime());
        return strtoupper(substr(md5($uid),0,2)) . date('YmdHis', $sec) . (int) ($usec * 1000000);
    }
}