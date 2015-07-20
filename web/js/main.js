/**
 * Created by bijiabo on 15/4/3.
 */

var updateElementsSize = function(){
    //更新元素尺寸

    /*
    $(".main>section").css({
        "width":$(window).width()+"px",
        "height":$(window).height()+"px"
    });
    */

    $("#welcome_container").css({
        "width":$(window).width()+"px",
        "height":$(window).height()+"px"
    });


    var grown_data_height = $(window).height() - Math.round($(window).width()/750*1027);
    //$("#grown_data").css({
    //    "width":grown_data_height/366*704+"px",
    //    "height":grown_data_height
    //});

    $("#playlist").css({
        "width":$(window).width()+"px",
        "height":  $(window).height() + "px" //($(window).height()-grown_data_height)+"px"
    });
};

var jssor_slider1;

jQuery(document).ready(function ($) {

    updateElementsSize();

    var welcomeContainer = $("#welcome_container");

    //welcome（引导和漫画界面）横向滚动
    $("#welcome_container>div.content").css({
        "width":$(window).width()+"px",
        "height":$(window).height()+"px"
    });

    var options = {
        $AutoPlay: false,
        $SlideWidth : $(window).width(),
        $Loop:false
    };
    jssor_slider1 = new $JssorSlider$('welcome_container', options);



    //responsive code begin
    //you can remove responsive code if you don't want the slider scales while window resizes
    function ScaleSlider() {
        var bodyWidth = $(window).width();
        if (bodyWidth)
            jssor_slider1.$ScaleWidth(Math.min(bodyWidth, 1920));
        else
            window.setTimeout(ScaleSlider, 30);
    }
    ScaleSlider();


    //main child info水平滑动
    var main_child_info_Slider = new Slider({
        listener : "#main_child_info .dragButton",
        dom : document.getElementById('main_child_info')
    });

    //连接到漫画列表
    $("#cartoon-list-button").tap( function( event ) {
        postWKMessage( { "action" : "link2CartoonList" } );
    } );

    $("#link2newsPage").tap(function(evt){
        //evt.preventDefault();
        //main_child_info_Slider.goIndex('+1');

        postWKMessage( { "action" : "link2CartoonList" } );
    });

    //结束引导，进入主界面
    $("#end-guide").tap(function(event){

        console.log("end guide");

        window.webkit.messageHandlers.notification.postMessage({
            "action" : "endGuide"
        });
    });


    //加载完毕，发送通知
    postWKMessage({
        "action" : "webViewDidLoad"
    });

    console.log("document ready");

});

var didFinishNavigation = function(){
    if(!window.webkit)
    {
        console.log("非wkwebkit环境，数据传递终止。");
    }

    var pageHeightArray = [];
    $.each($(".main>section"),function(index,item){
       pageHeightArray.push($(item).height());
    });
    console.log(pageHeightArray);

    var pageYArray = [0];
    for(var i= 0,len=pageHeightArray.length-1,heightCount=0;i<len;i++)
    {
        heightCount += pageHeightArray[i];
        pageYArray.push(heightCount);
    }

    window.webkit.messageHandlers.notification.postMessage({
        "action" : "initMain",
        "pageYArray" : pageYArray
    });
};

var postWKMessage = function(msg)
{
    if (window.webkit)
    {
        window.webkit.messageHandlers.notification.postMessage( msg );
    }
};