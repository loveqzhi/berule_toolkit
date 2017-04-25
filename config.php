<?php

const SESSION_PREFIX = 'toolkit#berule';

define('THEMEFOLDER', __DIR__ . '/theme');


//配置: session
$sessions = array(
    'prefix' => 'toolkit#smart',
);

//配置: 数据库
$databases = array(
    'default' => array(
        'host'      => '127.0.0.1',
        'port'      => 3306,
        'database'  => 'toolkit',
        'username'  => 'toolkit',
        'password'  => 'toolkit',
        'prefix'    => '',
    ),
);

//配置: 日志记录
$loggers = array(    
    'default' => array(
        'class' => 'Pyramid\Component\Logger\FileLogger',
        'level' => 'debug',
        //'file' => 'd:/www/logs/nearly_default',
		'file' => '/tmp/toolkit_default',
    ),
    'system' => array(
        'class' => 'Pyramid\Component\Logger\FileLogger',
        'level' => 'debug',
        //'file' => 'd:/www/logs/nearly_system',
		'file' => '/tmp/toolkit_system',
    ),
);

//配置: 模板引擎
$engines = array(
    'default' => array(
        'engine'      => 'Pyramid\Component\Templating\PhpEngine',
        'loader'      => 'Pyramid\Component\Templating\Php\Loader',
        'environment' => 'Pyramid\Component\Templating\Php\Environment',
        'loaderArgs' => array(THEMEFOLDER),
        'envArgs'    => array(/*'cache'=>'/opt/wwwroot/pay.berule.com/Cache/Theme'*/),
    ),
);

//配置：api status
$api_status = array(
    '200'   => 'OK',
    '10000' => '服务维护中',
    '10001' => '请填写完整信息',
    '10002' => '密码输入有误',
    '10003' => '该用户不存在',
    '10004' => '请输入用户名',
    '10005' => '缺少appid或mkey',
    '10006' => '无效的Appid',
    '10007' => '非法的秘钥',
    '10008' => '获取Token已超过次数',
    '10009' => '无效的Token',
    '10010' => '无效的邮箱接口',
    '10011' => '待发送地址有误',
	'10012' => '待发送手机号有误',
	'10013' => '无效的短信接口',
);

config()->set('status',$api_status);

//配置: swoole
$swooles = array(
    'mail' => array(
        'worker_num' => 2,
        'daemonize' => true,
        'max_request' => 100,
        'dispatch_mode' => 3,
        'debug_mode'=> 1,
        'log_file' => '/tmp/swoole_mail.log',
    ),
	'sms' => array(
        'worker_num' => 2,
        'daemonize' => true,
        'max_request' => 100,
        'dispatch_mode' => 3,
        'debug_mode'=> 1,
        'log_file' => '/tmp/swoole_sms.log',
    ),
);

$wechats = array(
    'test' => array(
        'name'    => '',
        'token'   => 'xMs39pC3', //微信设置的token
        'corpid'  => 'wx80de7f749968392f', //微信上的公司ID
        'corpsecret' => 'rwFtNEh65TOPmL25ffcVO1jslSX3206VuioRC8xzHljYfT8K681vUuqOUmWLyrYL', //秘钥
        'url'     => 'http://toolkit.xtaff.net/api/wechat',
        'encodingaeskey' => 'YbU2os8UbgHUDyfWKLvMpML6xm2LV5nrDx5N2NJKi7Q', //微信设置的密钥
    ),
);

config()->set('wechats',$wechats);



