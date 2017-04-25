<?php 

namespace Api\Wechat;

use Api\Wechat\WechatHttp as WechatHttp;
use Api\Wechat\Prpcrypt as Prpcrypt;

class WechatAPI {
    public static $config;
    
    //��ҵ�Żص���post�����е�����encrypt
    public static $encrypt;
    
    //��ҵ�Żص� ���Ľ��ܺ������
    public static $requestxml;
    
    //��ҵ�Żص���ǩ��signature
    public static $signature;
    
    //��ҵ�Żص��� timestamp
    public static $timestamp;
    
    //��ҵ�Żص��� nonce
    public static $nonce;
    
    //��ҵ�Żص��� ��ҵid
    public static $tousername;
    
    //��ҵ�Żص��� Ӧ��id
    public static $agentid;
    
    /*
     * ��Ȩ
     */
    public function checkAccess($config) {
        self::$signature = isset($_GET['msg_signature']) ? $_GET['msg_signature'] : '';
        self::$timestamp = isset($_GET['timestamp']) ? $_GET['timestamp'] : time();
        self::$nonce     = isset($_GET['nonce']) ? $_GET['nonce'] : '';
        
        if (isset($_GET['echostr'])) {  //��֤url
            $pc = new Prpcrypt($config['encodingaeskey']);
            $result = $pc->decrypt($_GET['echostr'],$config['corpid']);
            if ($result[0] != 0) {
                header('HTTP/1.0 403 Forbidden'); 
                exit('Access denied');
            }
            return $result[1];
        }
        else {//��֤ǩ��
            $data = WechatHttp::getRequest();
            self::$encrypt = $data['Encrypt'];  //�õ�����
            $pc = new Prpcrypt($config['encodingaeskey']);
            $result = $pc->decrypt(self::$encrypt, $config['corpid']);
            if ($result[0] != 0) {
                return false;
            } else {
                self::$requestxml  = $result[1];
            }           
            $hash = self::getSha1($config['token'], self::$timestamp, self::$nonce,self::$encrypt);
            if ($hash != self::$signature) {
                return false;
            }
            return true;
        }
    }
    
    

    /*
     * ���Ϳͷ���Ϣ
     */
    public static function send($request,$msg) {
        static $url = 'https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token=%s';
        $token = self::getToken($request);
        logger()->debug("#### Token is ".$token);
        return WechatHttp::curl(sprintf($url, $token), array(), self::json_encode($msg));        
    }

    /*
     * ��ȡaccess_token
     *
     * @return string
     */
    public  static function getToken($request) {
        static $token = array('token' => '', 'expired' => 0);
        static $url = 'https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=%s&corpsecret=%s';
        if (time() > $token['expired']) {
            list($header, $body) = WechatHttp::curl(sprintf($url, $request->params->getParameter('qyconfig')['corpid'], $request->params->getParameter('qyconfig')['corpsecret']));
            $json = json_decode($body, true);
            if (!$json || isset($json['errcode'])) {
                throw new Exception('can not access token.');          
            } else {
                $token['token']   = $json['access_token'];
                $token['expired'] = time() + 7200 - 120;
            }
        }
        return $token['token'];
    }

    /*
     * ��ȡ�����б�
     * 
     * @param int id ��������id
     * @return array( "id": 2,"name": "�����з�����","parentid": 1,"order": 10); 
     */
    public static function department($request) {
        $id  = $request->params->getParameter('id',1);
        $url = "https://qyapi.weixin.qq.com/cgi-bin/department/list?id=".$id."&access_token=%s"; 
        $token = self::getToken($request);
        list($header, $body) = WechatHttp::curl(sprintf($url, $token), array(), array());
        $json = json_decode($body, true);
        return $json;
    }
    /*
     * �ϴ���ý���ļ�
     *
     * image 128K, voice 256K, video 1M, thumb 64K     
     * @return array(type => , media_id => , created_at => )
     */
    public function uploadFile($type, $file) {
        static $url = 'http://file.api.weixin.qq.com/cgi-bin/media/upload?access_token=%s&type=%s';
        $token = $this->getToken();
        list($header, $body) = WechatHttp::curl(sprintf($url, $token, $type), array(), array('media' => '@'.realpath($file)));
        $json = json_decode($body, true);
        if (!$json || isset($json['errcode'])) {
            throw new Exception('failed to upload file.');
        } else {
            return $json;
        }
    }

    /*
     * ���ض�ý���ļ�
     *
     * @return binary
     */
    public function downloadFile($media_id) {
        static $url = 'http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=%s&media_id=%s';
        $token = $this->getToken();
        list($header, $body) = WechatHttp::curl(sprintf($url, $token, $media_id));
        if (substr($body,0,1) == '{') {
            throw new Exception('can not download media file.');
        } else {
            return $body;
        }
    }

    /*
     * ��ȡ�û���Ϣ
     @return array(subscribe=>1, openid=>, nickname=>, sex=>, language=>, province=>, city=>, country=>, headimgurl=>, subscribe_time=>,)
     */
    public function getUserInfo($openid) {
        static $url = 'https://api.weixin.qq.com/cgi-bin/user/info?access_token=%s&openid=%s&lang=zh_CN';
        $token = $this->getToken();
        list($header, $body) = WechatHttp::curl(sprintf($url, $token, $openid));
        $json = json_decode($body, true);
        if (!$json || isset($json['errcode'])) {
            throw new Exception('failed to get user info.');
        } else {
            return $json;
        }
    }

    /*
     * ��ȡ��ע���б�
     * @param int status 0��ȡȫ��Ա����1��ȡ�ѹ�ע��Ա�б�2��ȡ���ó�Ա�б�4��ȡδ��ע��Ա�б�status�ɵ���
     */
    public function getUserList($request) {
        $url = "https://qyapi.weixin.qq.com/cgi-bin/user/list?access_token=%s&department_id=%s&fetch_child=%s&status=%s";
        $url = vsprintf($url, array(
            self::getToken($request),
            $request->get('department_id',1),
            $request->get('fetch_child',1),
            $request->get('status',0),
        ));
        list($header, $body) = WechatHttp::curl($url);
        $json = json_decode($body, true);
        return $json;
    }

    /*
     * �����Զ���˵�
     */
    public function createMenu($menu) {
        static $url = 'https://api.weixin.qq.com/cgi-bin/menu/create?access_token=%s';
        $token = $this->getToken();
        list($header, $body) = WechatHttp::curl(sprintf($url, $token), array(), $this->json_encode($menu));
        $json = json_decode($body, true);
        if (!$json || $json['errcode'] != 0) {
            return false;
        } else {
            return true;
        }
    }

    /*
     * ��ѯ�Զ���˵�
     */
    public function getMenu() {
        static $url = 'https://api.weixin.qq.com/cgi-bin/menu/get?access_token=%s';
        $token = $this->getToken();
        list($header, $body) = WechatHttp::curl(sprintf($url, $token));
        $json = json_decode($body, true);
        if (!$json || isset($json['errcode'])) {
            return false;
        } else {
            return $json;
        }
    }

    /*
     * ɾ���Զ���˵�
     */
    public function deleteMenu() {
        static $url = 'https://api.weixin.qq.com/cgi-bin/menu/delete?access_token=%s';
        $token = $this->getToken();
        list($header, $body) = WechatHttp::curl(sprintf($url, $token));
        $json = json_decode($body, true);
        if (!$json || $json['errcode'] != 0) {
            return false;
        } else {
            return true;
        }
    }

    /*
     * �û�ͬ����Ȩ����ȡcode
     */
    public function getWebCodeUrl($redirect_uri, $state = '', $scope = 'snsapi_userinfo') {
        static $url = 'https://open.weixin.qq.com/connect/oauth2/authorize?%s#wechat_redirect';
        $query = array(
            'appid'         => $this->config['appid'],
            'redirect_uri'  => $redirect_uri,
            'response_type' => 'code',
            'scope'         => $scope,
            'state'         => $state,
        );

        return sprintf($url, http_build_query($query));
    }
    
    /*
     * ͨ��code��ȡ��ҳ��Ȩaccess_token
     */
    public function getWebToken($code) {
        static $url = 'https://api.weixin.qq.com/sns/oauth2/access_token?%s';
        $query = array(
            'appid'      => $this->config['appid'],
            'secret'     => $this->config['secret'],
            'code'       => $code,
            'grant_type' => 'authorization_code',
        );
        list($header, $body) = WechatHttp::curl(sprintf($url, http_build_query($query)));
        $json = json_decode($body, true);
        if (!$json || isset($json['errcode'])) {
            throw new Exception('failed to upload file.');
        } else {
            return $json;
        }
    }

    /*
     * ˢ��access_token
     */
    public function refreshWebToken($token) {
        static $url = 'https://api.weixin.qq.com/sns/oauth2/refresh_token?%s';
        $query = array(
            'appid'         => $this->config['appid'],
            'grant_type'    => 'refresh_token',
            'refresh_token' => $token,
        );
        list($header, $body) = WechatHttp::curl(sprintf($url, http_build_query($query)));
        $json = json_decode($body, true);
        if (!$json || isset($json['errcode'])) {
            throw new Exception('failed to upload file.');
        } else {
            return $json;
        }
    }
    
    /*
     * ��ȡ�û���Ϣ(��scopeΪ snsapi_userinfo)
     * @return array(openid=>, nickname=>, sex=>, province=>, city=>, country=>, headimgurl=>, privilege:[])
     */
    public function getWebUserInfo($openid, $token) {
        static $url = 'https://api.weixin.qq.com/sns/userinfo?access_token=%s&openid=%s&lang=zh_CN';
        list($header, $body) = WechatHttp::curl(sprintf($url, $token, $openid));
        $json = json_decode($body, true);
        if (!$json || isset($json['errcode'])) {
            throw new Exception('failed to get user info.');
        } else {
            return $json;
        }
    }

    //����json����
    protected static function json_encode($data) {
        if (version_compare(PHP_VERSION, '5.4.0', '<')) {
            return urldecode(json_encode($this->urlencode($data)));
        } else {
            return json_encode($data, JSON_UNESCAPED_UNICODE);
        }
    }
    
    //ת������
    protected function urlencode($data) {
        if (is_array($data)) {
            foreach ($data as $k => $v) {
                $data[urlencode($k)] = $this->urlencode($v);
            }
        } else {
            $data = urlencode($data);
        }
        
        return $data;
    }
    
    public static function getSha1($token, $timestamp, $nonce, $encrypt_msg)
	{
		//����
		try {
			$array = array($encrypt_msg, $token, $timestamp, $nonce);
			sort($array, SORT_STRING);
			$str = implode($array);
			return  sha1($str);
		} catch (Exception $e) {
			print $e . "\n";
			return null;
		}
	}
}