<?php

/**
 * @ file
 *  
 * @ Mail 邮件中心
 */

namespace Entity\Mail;
use Entity;
use PDO;
entity_register('mail', array(
    'primaryKey' => 'id',
    'baseTable'  => 'mail',
));


class Mail {

    //根据主键读取
    public static function load($request) {
        $id  = (int) $request->getParameter('id');
        $data = entity_load('mail', array($id));
        return reset($data);
    }

    //根据主键读取多个
    public static function loadMulti($request) {
        $ids = $request->getParameter('ids');
        if ($ids && !is_array($ids)) {
            $ids = explode(',', $ids);
        }
        $data = entity_load('mail', $ids);
        return $data;
    }

    //loadByMsgid
    public static function loadByMsgid($request) {
        $msgid = $request->getParameter('msgid');
        $data  = entity_load('mail', array(), array('msgid'=>$msgid));
        return reset($data);
    }

    //新增
    public static function insert($request) {
        $mail = (object) $request->getParameters();
        unset($mail->id);
        $mail->updated = time();
        entity_insert('mail', $mail);
        return $mail;
    }
    
    //修改
    public static function update($request) {
        $mail = (object) $request->getParameters();
        unset($mail->created);
        entity_update('mail', $mail);
        return $mail;
    }

    //发送列表
    public static function search($request) {
        $navi   = array('page'=> 1,'size' => 10, 'total'=> 0, 'pages' => 1);
        $page   = (int) $request->getParameter('page', 1);
        $size   = (int) $request->getParameter('size', 10);
        $query  = db_select('mail', 'm')
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
     * 站内邮件发送
     * @param  int    $boxid    使用的邮箱接口ID
     * @param  int    $uid      用户UID
     * @param  string $address  发送地址
     * @param  string $subject  主题
     * @param  string $body     正文
     * @param  string $is_html  是否html
     * @param  string $cc       抄送地址
     * @param  string $bcc      密送地址
     * @param  array  $attachment   附件
     */
    public static function send($request){
        $uid = $request->getParameter('uid',null);
        $boxid = $request->getParameter('boxid',null);
        $config = Entity\User\User::getUserMailOption($uid,$boxid);
        $data = array(
            'address'   => $request->getParameter('address'),
            'subject'   => $request->getParameter('subject'),
            'body'      => $request->getParameter('body'),
            'cc'        => $request->getParameter('cc'),
            'bcc'       => $request->getParameter('bcc'),
            'attachments' => $request->getParameter('attachment',array()),
            'is_html'   => $request->getParameter('is_html'),
        );
        $array = array(
            'type'      => 1,
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