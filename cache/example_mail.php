<?php 

$appid  = 'blC420141220154047563087';
$secret = '$S$a4bdc7628a2451de9334f69380b6fffda499322d62df9dbfd3cbf5d83514c';

$host = "http://toolkit.xtaff.net/";    //"http://dev.toolkit.com";

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

//Get my email interface server
$response =  curl($host . "/api/mail/interface/?token=".$token);
$mails = json_decode($response,true);
if(!empty($mails['data'])) {
    foreach($mails['data'] as $mail) {
        if($mail['status']==1) {
            $interface = $mail['name']; //也可从列表中选一个接口
            break;
        }
    }
}
//var_dump($interface);exit;

//发送邮件
$param = array(
    'token' => $token,
    'data'  => array(
        'address' => '2207860301@qq.com',
        'subject' => date('Y-m-d H:i').' 我在测试中...',
        'body'    => '11111111111111111<br>222222222222222<br>3333333333333',
    ),
);

$response = curl($host . "/api/mail/send/".$interface,$param);

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
