<?php 

$appid  = 'blC420141220154047563087';
$secret = '$S$a4bdc7628a2451de9334f69380b6fffda499322d62df9dbfd3cbf5d83514c';

$host = "http://toolkit.xtaff.net";    //"http://dev.toolkit.com";

//use mail interface
//$interface = 'mail5';

//Get Token
$mkey = md5($appid . $secret);
//{
//    "status":200,
//    "message":"OK",
//    "data":{
//        "token":"blA920141225164440761724",
//        "expired":1419504280
//        },
//    "variables":{}
//}

$response = curl($host . "/api/token/?appid=".$appid."&mkey=".$mkey);
$token_data = json_decode($response,true);
$token = $token_data['data']['token'];

//Get my sms interface server
$response =  curl($host . "/api/sms/interface/?token=".$token);

$sms = json_decode($response,true);
if(!empty($sms['data'])) {
    foreach($sms['data'] as $config) {
        if($config['status']==1) {
            $interface = $config['name']; //也可从列表中选一个接口
            break;
        }
    }
}
$interface='sms2';
//var_dump($interface);exit;

//发送短信
$param = array(
    'token' => $token,
    'data'  => array(
        'phone' => '13524184107',
        'content' => '测试,感谢你登录我们系统，你的密码是xxxxxx',
    ),
);

$response = curl($host . "/api/sms/send/".$interface,$param);

var_dump(json_decode($response,true));

function curl($url, $params = array()) {
    $header = array();
    $ch = curl_init();
    $option = array(
        CURLOPT_URL             => $url,
        CURLOPT_HTTPHEADER      => $header,
        CURLOPT_HEADER          => false,
        CURLOPT_FOLLOWLOCATION  => true,
        CURLOPT_RETURNTRANSFER  => true,
        CURLOPT_CONNECTTIMEOUT  => 10,
        CURLOPT_TIMEOUT         => 30,
    );
    if (count($params)) {
        $option[CURLOPT_POST] = true;
        $option[CURLOPT_POSTFIELDS] = http_build_query($params);
    }
    if (stripos($url, 'https') === 0) {
        $option[CURLOPT_SSL_VERIFYPEER] = false;
        $option[CURLOPT_SSL_VERIFYHOST] = false;
    }
    curl_setopt_array($ch, $option);
    $content = curl_exec($ch);
    if (curl_errno($ch) > 0) {
        $content = '';
    }
    curl_close($ch);
    return $content;
}
