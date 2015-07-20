/**
 * Created by bijiabo on 15/4/5.
 */
var corona = function(option){
    this.container = $("#"+option.container);
    this.oval = this.container.find(".oval");
    this.containerSelectString = "#"+ option.container;
    this.ovalSelectString = "#"+ option.container + ">.oval";
    this.init();
    this.bindDOM();
};

corona.prototype.init = function(){
    /*
    this.oval.prepend('<div class="wall"></div>\
        <div class="floor"></div>\
        <div class="scene"></div>\
        <div class="white"></div>');
    */
    //this.oval.get(0).style.webkitTransform = "rotate(60deg)";
    this.rotate(60);
};

corona.prototype.rotate = function(r){

    this.oval.get(0).style.webkitTransform = "rotate("+r+"deg)";
};

corona.prototype.bindDOM = function(){
    var self = this;

    //手指按下的处理事件
    this.startHandler = function(evt){
        //记录刚刚开始按下的时间
        self.startTime = new Date() * 1;

        //记录手指按下的坐标
        self.startX = evt.originalEvent.touches[0].pageX - $(window).width()/2;
        self.startY = evt.originalEvent.touches[0].pageY - (self.oval.offset().top + self.oval.height()/2);
        self.startAngle = Math.atan(self.startY / self.startX) * 180 / Math.PI;
        self.startAngle = self.startAngle>0?self.startAngle:180+self.startAngle;

        self.originalAngle = Number(self.oval.get(0).style.webkitTransform.match(/\-?\d+\.?[\d]*/g)[0]);

        //console.log("startAngle : " + self.startAngle);
        //console.log("originalAngle : " + self.originalAngle);
    };

    //手指移动的处理事件
    this.moveHandler = function(evt){
        //兼容chrome android，阻止浏览器默认行为
        evt.preventDefault();

        //计算手指的偏移量
        var moveX = evt.originalEvent.touches[0].pageX - $(window).width()/2;
        var moveY = evt.originalEvent.touches[0].pageY - (self.oval.offset().top + self.oval.height()/2);
        var moveAngle = Math.atan(moveY / moveX) * 180 / Math.PI;
        moveAngle = moveAngle>0?moveAngle:180+moveAngle;

        var angleDifference = moveAngle - self.startAngle;
        var ovalAngle = self.originalAngle + angleDifference;
        //console.log("angleDifference : " + angleDifference);

        //self.oval.get(0).style.webkitTransform = "rotate("+ovalAngle+"deg)";
        self.rotate(ovalAngle);

    };

    //手指抬起的处理事件
    this.endHandler = function(evt){
        console.log($(evt.currentTarget).attr("id"));
        evt.preventDefault();

        //边界就翻页值
        var boundary = self.scaleW/6;

        //手指抬起的时间值
        var endTime = new Date() * 1;

        //所有列表项
        var lis = $(outer).find(".page_container");

        //当手指移动时间超过300ms 的时候，按位移算
        if(endTime - self.startTime > 300){
            if(self.offsetX >= boundary){
                self.goIndex('-1');
            }else if(self.offsetX < 0 && self.offsetX < -boundary){
                self.goIndex('+1');
            }else{
                self.goIndex('0');
            }
        }else{
            //优化
            //快速移动也能使得翻页
            if(self.offsetX > 50){
                self.goIndex('-1');
            }else if(self.offsetX < -50){
                self.goIndex('+1');
            }else{
                self.goIndex('0');
            }
        }
    };

    //绑定事件
    $(document).on("touchstart",self.containerSelectString,self.startHandler);
    $(document).on("touchmove",self.containerSelectString,self.moveHandler);
    //$(document).on("touchend",self.listener,self.endHandler);


};

var mainUserInfo;

$(function(){
    window.mainUserInfo = new corona({
        container : "corona_demo"
    });
});