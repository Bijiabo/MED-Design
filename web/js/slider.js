/**
 * Created by bijiabo on 15/4/5.
 */
//构造函数
function Slider(opts){
    //构造函数需要的参数
    this.wrap = opts.dom;
    this.listener = opts.listener;
    //构造三步奏
    this.init();
    this.renderDOM();
    this.bindDOM();
}

//第一步 -- 初始化
Slider.prototype.init = function() {
    //设定窗口比率
    this.radio = window.innerHeight/window.innerWidth;
    //设定一页的宽度
    this.scaleW = window.innerWidth;
    //设定初始的索引值
    this.idx = 0;

    this.outer = this.wrap;

    $(this.outer).css({
        width:$(window).width()+"px",
        height:$(window).height()+"px"
    });
};

//第二步 -- 根据数据渲染DOM
Slider.prototype.renderDOM = function(){

    var self = this;

    $.each($(this.outer).find(".page_container"),function(index,item){
        $(item).width(window.innerWidth);
        item.style.webkitTransform = 'translate3d('+ index*self.scaleW +'px, 0, 0)';
    });

};

Slider.prototype.goIndex = function(n){
    var idx = this.idx;
    var lis = $(this.outer).find(".page_container");
    var len = lis.length;
    var cidx;

    //如果传数字 2,3 之类可以使得直接滑动到该索引
    if(typeof n == 'number'){
        cidx = idx;
        //如果是传字符则为索引的变化
    }else if(typeof n == 'string'){
        cidx = idx + n*1;
    }

    //当索引右超出
    if(cidx > len-1){
        cidx = len - 1;
        //当索引左超出
    }else if(cidx < 0){
        cidx = 0;
    }

    //保留当前索引值
    this.idx = cidx;

    //改变过渡的方式，从无动画变为有动画
    lis[cidx].style.webkitTransition = '-webkit-transform 0.2s ease-out';
    lis[cidx-1] && (lis[cidx-1].style.webkitTransition = '-webkit-transform 0.2s ease-out');
    lis[cidx+1] && (lis[cidx+1].style.webkitTransition = '-webkit-transform 0.2s ease-out');

    //改变动画后所应该的位移值
    lis[cidx].style.webkitTransform = 'translate3d(0, 0, 0)';
    lis[cidx-1] && (lis[cidx-1].style.webkitTransform = 'translate3d(-'+ this.scaleW +'px, 0, 0)');
    lis[cidx+1] && (lis[cidx+1].style.webkitTransform = 'translate3d('+ this.scaleW +'px, 0, 0)');
};

//第三步 -- 绑定 DOM 事件
Slider.prototype.bindDOM = function(){
    var self = this;
    var outer = self.outer;

    //手指按下的处理事件
    this.startHandler = function(evt){
        //记录刚刚开始按下的时间
        self.startTime = new Date() * 1;

        //记录手指按下的坐标
        self.startX = evt.originalEvent.touches[0].pageX;

        //清除偏移量
        self.offsetX = 0;

        //事件对象
        var target = evt.target;
        while(target.nodeName != 'LI' && target.nodeName != 'BODY'){
            target = target.parentNode;
        }
        self.target = target;

    };

    //手指移动的处理事件
    this.moveHandler = function(evt){
        //兼容chrome android，阻止浏览器默认行为
        evt.preventDefault();

        //计算手指的偏移量
        self.offsetX = evt.originalEvent.touches[0].pageX - self.startX;

        var lis = $(outer).find(".page_container");
        //起始索引
        var i = self.idx - 1;
        //结束索引
        var m = i + 3;

        //最小化改变DOM属性
        for(i; i < m; i++){
            lis[i] && (lis[i].style.webkitTransition = '-webkit-transform 0s ease-out');
            lis[i] && (lis[i].style.webkitTransform = 'translate3d('+ ((i-self.idx)*self.scaleW + self.offsetX) +'px, 0, 0)');
        }
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
    $(document).on("touchstart",self.listener,self.startHandler);
    $(document).on("touchmove",self.listener,self.moveHandler);
    $(document).on("touchend",self.listener,self.endHandler);
    /*
    this.listener.addEventListener('touchstart', this.startHandler);
    this.listener.addEventListener('touchmove', this.moveHandler);
    this.listener.addEventListener('touchend', this.endHandler);
    */
};

/*
//初始化Slider 实例
new Slider({
    dom : document.getElementById('canvas'),
    list : list
});*/
