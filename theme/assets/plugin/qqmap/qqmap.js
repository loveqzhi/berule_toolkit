
var QQMap = {

    map : null,
    searchService : null,
    pointMarker : null,

    hasInit: false,
    
    options : {
        mapDiv           : 'container',             //div对象ID
        mapLevel         : 15,                      //地图缩放等级
        mapCenter        : '31.247200,121.430344',  //地图中心点 坐标or城市名
    },

    init: function(options) {
        if (this.hasInit) {
            return ;
        }
        var options = this.setOptions(options);
        if ($('#'+options.mapDiv).size() <= 0) { return ; }
        this.map = new qq.maps.Map(document.getElementById(options.mapDiv), {
            center: new qq.maps.LatLng(options.mapCenter.split(',')[0], options.mapCenter.split(',')[1]),
            zoomLevel: options.mapLevel,
            scrollwheel: false
        });
        this.hasInit = true;
    },
    
    setMarkers: function (markers) {
        var latLng;
        for (i in markers) {
            latLng = new qq.maps.LatLng(markers[i].lat, markers[i].lng);
            new qq.maps.Marker({
                position: latLng,
                draggable: false,
                map: this.map
            });
        }
    },
    
    setMarkerImage:function(lat, lng) {
        var anchor  = new qq.maps.Point(6, 6),
            size    = new qq.maps.Size(24, 24),
            origin  = new qq.maps.Point(0, 0);
        var icon = new qq.maps.MarkerImage('http://open.map.qq.com/javascript_v2/img/center.gif', size, origin, anchor);
        var latLng = new qq.maps.LatLng(lat, lng);
        new qq.maps.Marker({
            icon: icon,
            position: latLng,
            draggable: false,
            map: this.map
        });
    },
    
    center: function(lat, lng) {
        var latLng = new qq.maps.LatLng(lat, lng);
        this.map.zoomTo(13);
        this.map.setCenter(latLng);
    },
    
    search: function(region, point) {
        var This = this;
        if (!this.searchService) {
            this.searchService = new qq.maps.SearchService({
                pageCapacity : 1,
                complete: function(SearchResult){
                    if (SearchResult.detail.pois[0].latLng) {
                        This.moveMarker(SearchResult.detail.pois[0].latLng);
                    } else {
                        alert("无匹配的结果,请调整搜索关键词");
                    }
                }
            });
        }
        this.searchService.setLocation(region);
        this.searchService.search(point);
    },
    
    moveMarker: function(latLng) {
        if (!this.pointMarker) {
            this.pointMarker = new qq.maps.Marker({
                position: latLng,
                draggable: true,
                map: this.map
            });
            this.map.zoomTo(15);
            qq.maps.event.addDomListener(this.pointMarker,'dragend',function(event){
                qqmap_dragend(event.latLng.getLng().toFixed(6), event.latLng.getLat().toFixed(6));
            });
        }
        this.map.setCenter(latLng);
        this.pointMarker.setPosition(latLng);
    },
    
    setOptions : function(options) {
        return this._set(options, this.options);
    },
    _set : function(source, dest) {
        for(var key in source) {
          dest[key] = source[key];
        }
        return dest;
    },

}

function qqmap_toggle() {
    if($('#divmap').css('left')=='59px') {
        $('#divmap').css('left','-9999px'); 
    } else {
        $('#divmap').css('left','59px'); 
    }
    qqmap_init();
}
function qqmap_init() {
    if($('#divmap').css('left')!='59px') return;
    var sheng = $('.prov').val();
    var djs = $('.city').val();
    var lng = $('#lng').val();
    var lat = $('#lat').val();
    var mapcity = $('#mapcity').val();
    if (!mapcity) {
        $('#mapcity').val(sheng);
    }
    if (lng && lat) {
        QQMap.moveMarker(new qq.maps.LatLng(lat, lng));
    } else if (djs) {
        QQMap.search(sheng, djs);
    } else {
        
    }
}
function qqmap_dragend(lng,lat){
    $('#lng').val(lng);
    $('#lat').val(lat);
}

$(function(){
    QQMap.init();
});
