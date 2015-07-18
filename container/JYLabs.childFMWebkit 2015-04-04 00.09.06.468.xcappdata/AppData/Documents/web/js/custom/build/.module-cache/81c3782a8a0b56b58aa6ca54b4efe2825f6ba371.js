/**
 * Created by bijiabo on 15/4/20.
 */

React.initializeTouchEvents(true);

var testData = {
    "normal" : {
        "title" : "日常",
        "playList" : [
            {
                "Title": "Let It Go23333",
                "Description": "《Let It Go》是华特迪士尼动画工作室的2013年动画作品《冰雪奇缘》当中的主题曲，翻唱版由Alex Boye、Lexi walker（11岁）和美国儿童合唱团联合演绎。",
                "Url": "Let It Go.mp3",
                "PlayCount": 3
            },
            {
                "Title": "The Music Room",
                "Description": "一首关于钢琴的英文儿歌，旋律动听，歌词简单，易于学唱。",
                "Url": "The Music Room.mp3",
                "PlayCount": 1
            },
            {
                "Title": "Colour Song",
                "Description": "这是一首关于颜色的儿歌，通过重复的旋律和内容让小朋友记住不同颜色的英文名称。",
                "Url": "Colour Song.mp3",
                "PlayCount": 2
            },
            {
                "Title": "Let It Go23333",
                "Description": "《Let It Go》是华特迪士尼动画工作室的2013年动画作品《冰雪奇缘》当中的主题曲，翻唱版由Alex Boye、Lexi walker（11岁）和美国儿童合唱团联合演绎。",
                "Url": "Let It Go.mp3",
                "PlayCount": 3
            },
            {
                "Title": "The Music Room",
                "Description": "一首关于钢琴的英文儿歌，旋律动听，歌词简单，易于学唱。",
                "Url": "The Music Room.mp3",
                "PlayCount": 1
            },
            {
                "Title": "Colour Song",
                "Description": "这是一首关于颜色的儿歌，通过重复的旋律和内容让小朋友记住不同颜色的英文名称。",
                "Url": "Colour Song.mp3",
                "PlayCount": 2
            }
        ]
    },
    "sleep" : {
        "title" : "睡前",
        "playList" : [
            {
                "Title": "Just for you",
                "Description": "",
                "Url": "Just for you.mp3",
                "PlayCount": 3
            },
            {
                "Title": "Classical Baby",
                "Description": "",
                "Url": "Classical Baby.mp3",
                "PlayCount": 3
            },
            {
                "Title": "Always With Me",
                "Description": "",
                "Url": "Always With Me.mp3",
                "PlayCount": 3
            },
            {
                "Title": "夜莺",
                "Description": "",
                "Url": "夜莺.mp3",
                "PlayCount": 3
            },
            {
                "Title": "梁祝-化蝶",
                "Description": "",
                "Url": "梁祝-化蝶.mp3",
                "PlayCount": 3
            },
            {
                "Title": "晚安晚安",
                "Description": "",
                "Url": "晚安晚安.mp3",
                "PlayCount": 3
            }
        ]
    },
    "getup" : {
        "title" : "起床",
        "playList" : [
            {
                "Title": "里姆斯基·科萨科夫-野蜂飞舞",
                "Description": "",
                "Url": "里姆斯基·科萨科夫-野蜂飞舞.mp3",
                "PlayCount": 3
            },
            {
                "Title": "德语圣诞歌 - Schnuffels Weihnachtslied",
                "Description": "",
                "Url": "德语圣诞歌 - Schnuffels Weihnachtslied.mp3",
                "PlayCount": 3
            },
            {
                "Title": "斯美塔那-伏尔塔瓦河",
                "Description": "",
                "Url": "斯美塔那-伏尔塔瓦河.mp3",
                "PlayCount": 3
            },
            {
                "Title": "渔舟唱晚",
                "Description": "",
                "Url": "渔舟唱晚.mp3",
                "PlayCount": 3
            },
            {
                "Title": "小狗合唱团",
                "Description": "",
                "Url": "小狗合唱团.mp3",
                "PlayCount": 3
            },
            {
                "Title": "牛车上的阳光",
                "Description": "",
                "Url": "牛车上的阳光.mp3",
                "PlayCount": 3
            }
        ]
    },
    "test" : {
        "title" : "测试",
        "playList" : [
            {
                "Title": "里姆斯基·科萨科夫-野蜂飞舞testing...",
                "Description": "",
                "Url": "里姆斯基·科萨科夫-野蜂飞舞.mp3",
                "PlayCount": 3
            },
            {
                "Title": "德语圣诞歌 - Schnuffels Weihnachtslied",
                "Description": "",
                "Url": "德语圣诞歌 - Schnuffels Weihnachtslied.mp3",
                "PlayCount": 3
            },
            {
                "Title": "斯美塔那-伏尔塔瓦河",
                "Description": "",
                "Url": "斯美塔那-伏尔塔瓦河.mp3",
                "PlayCount": 3
            },
            {
                "Title": "渔舟唱晚",
                "Description": "",
                "Url": "渔舟唱晚.mp3",
                "PlayCount": 3
            },
            {
                "Title": "小狗合唱团",
                "Description": "",
                "Url": "小狗合唱团.mp3",
                "PlayCount": 3
            },
            {
                "Title": "牛车上的阳光",
                "Description": "",
                "Url": "牛车上的阳光.mp3",
                "PlayCount": 3
            }
        ]
    }
};

var testData2 = {
    "normal" : {
        "title" : "日常2",
        "playList" : [
            {
                "Title": "Let It Go",
                "Description": "《Let It Go》是华特迪士尼动画工作室的2013年动画作品《冰雪奇缘》当中的主题曲，翻唱版由Alex Boye、Lexi walker（11岁）和美国儿童合唱团联合演绎。",
                "Url": "Let It Go.mp3",
                "PlayCount": 3
            },
            {
                "Title": "The Music Room",
                "Description": "一首关于钢琴的英文儿歌，旋律动听，歌词简单，易于学唱。",
                "Url": "The Music Room.mp3",
                "PlayCount": 1
            },
            {
                "Title": "Colour Song",
                "Description": "这是一首关于颜色的儿歌，通过重复的旋律和内容让小朋友记住不同颜色的英文名称。",
                "Url": "Colour Song.mp3",
                "PlayCount": 2
            },
            {
                "Title": "Let It Go23333",
                "Description": "《Let It Go》是华特迪士尼动画工作室的2013年动画作品《冰雪奇缘》当中的主题曲，翻唱版由Alex Boye、Lexi walker（11岁）和美国儿童合唱团联合演绎。",
                "Url": "Let It Go.mp3",
                "PlayCount": 3
            },
            {
                "Title": "The Music Room",
                "Description": "一首关于钢琴的英文儿歌，旋律动听，歌词简单，易于学唱。",
                "Url": "The Music Room.mp3",
                "PlayCount": 1
            },
            {
                "Title": "Colour Song",
                "Description": "这是一首关于颜色的儿歌，通过重复的旋律和内容让小朋友记住不同颜色的英文名称。",
                "Url": "Colour Song.mp3",
                "PlayCount": 2
            }
        ]
    },
    "sleep" : {
        "title" : "睡前",
        "playList" : [
            {
                "Title": "Just for you",
                "Description": "",
                "Url": "Just for you.mp3",
                "PlayCount": 3
            },
            {
                "Title": "Classical Baby",
                "Description": "",
                "Url": "Classical Baby.mp3",
                "PlayCount": 3
            },
            {
                "Title": "Always With Me",
                "Description": "",
                "Url": "Always With Me.mp3",
                "PlayCount": 3
            },
            {
                "Title": "夜莺",
                "Description": "",
                "Url": "夜莺.mp3",
                "PlayCount": 3
            },
            {
                "Title": "梁祝-化蝶",
                "Description": "",
                "Url": "梁祝-化蝶.mp3",
                "PlayCount": 3
            },
            {
                "Title": "晚安晚安",
                "Description": "",
                "Url": "晚安晚安.mp3",
                "PlayCount": 3
            }
        ]
    },
    "getup" : {
        "title" : "起床",
        "playList" : [
            {
                "Title": "里姆斯基·科萨科夫-野蜂飞舞",
                "Description": "",
                "Url": "里姆斯基·科萨科夫-野蜂飞舞.mp3",
                "PlayCount": 3
            },
            {
                "Title": "德语圣诞歌 - Schnuffels Weihnachtslied",
                "Description": "",
                "Url": "德语圣诞歌 - Schnuffels Weihnachtslied.mp3",
                "PlayCount": 3
            },
            {
                "Title": "斯美塔那-伏尔塔瓦河",
                "Description": "",
                "Url": "斯美塔那-伏尔塔瓦河.mp3",
                "PlayCount": 3
            },
            {
                "Title": "渔舟唱晚",
                "Description": "",
                "Url": "渔舟唱晚.mp3",
                "PlayCount": 3
            },
            {
                "Title": "小狗合唱团",
                "Description": "",
                "Url": "小狗合唱团.mp3",
                "PlayCount": 3
            },
            {
                "Title": "牛车上的阳光",
                "Description": "",
                "Url": "牛车上的阳光.mp3",
                "PlayCount": 3
            }
        ]
    }
};
/*
* play list
*/
var mountTipString = function(componentName){
    return "[ "+componentName+" ] did mount.";
};

var mountTip = function(compneentName){
    console.log(mountTipString(compneentName));
};


/*
 * container
 * */
var PlayerContainer = React.createClass({displayName: "PlayerContainer",
    getInitialState: function() {
        return {
            playListData : {
                "normal" : {
                    "title" : "",
                    "playList" : []
                }
            },
            modeKey : "normal",
            playIndex : 0
        };
    },
    handleSwitchMode : function(modeKey){
        if (this.state.modeKey !== modeKey)
        {

            sendMessage2WKWebkit({
                action: "changeMode",
                mode : modeKey
            });

            this.setState({
                modeKey:modeKey
            });
        }
    },
    componentDidMount : function(){
        /*
        var self = this;
        $.getJSON(this.props.dataUrl,{},function(playListData){
            self.setState({
                playListData:playListData,
            });
        });
        */

        this.setState({playListData : this.props.initData});
        mountTip("PlayContainer");
    },
    render : function(){
        return (
            React.createElement("div", {className: "player-container"}, 
                React.createElement(PlayerChart, null), 

                React.createElement(PlayList, {data: this.state.playListData[this.state.modeKey], modeKey: this.state.modeKey, playIndex: this.state.playIndex}), 

                React.createElement(ModeList, {data: this.state.playListData, onSwitchMode: this.handleSwitchMode, modeKey: this.state.modeKey})
            )
        )
    }
});

var PlayerChart = React.createClass({displayName: "PlayerChart",
    componentDidMount : function(){

        mountTip("Player Chart");

        var data = [
            {
                value: 300,
                color:"#84cbc5",
                highlight: "#84cbc5",
                label: "Red"
            },
            {
                value: 50,
                color: "#fad260",
                highlight: "#fad260",
                label: "Green"
            },
            {
                value: 100,
                color: "#f47264",
                highlight: "#f47264",
                label: "Yellow"
            },
            {
                value: 40,
                color: "#7dc7ee",
                highlight: "#7dc7ee",
                label: "Grey"
            },
            {
                value: 120,
                color: "#1d69a5",
                highlight: "#1d69a5",
                label: "Dark Grey"
            },
            {
                value: 120,
                color: "#878ad1",
                highlight: "#878ad1",
                label: "Dark Grey"
            }
        ];

        // Get context with jQuery - using jQuery's .get() method.
        var ctx = $("#myChart").get(0).getContext("2d");
        // This will get the first returned node in the jQuery collection.
        new Chart(ctx).Pie(data, {
            scaleShowLabelBackdrop : false,
            segmentShowStroke : true,
            segmentStrokeWidth : 4,
            segmentStrokeColor: "#ffffff",
            scaleShowLine : false,
            animationSteps : 50,
            scaleShowLabels : false,
            percentageInnerCutout:0,
            scaleBeginAtZero: false,
            animateScale: true,
            animateRotate : true,
            showScale:false
        });

    },
    render : function(){
        return(
            React.createElement("div", {className: "player-chart"}, 
                React.createElement("canvas", {id: "myChart", width: "200", height: "200"})
            )
        );
    }
});


/*
* play list
* */

var PlayList = React.createClass({displayName: "PlayList",
    getInitialState: function() {
        return {
            activeIndex : 0
        };
    },
    componentDidMount : function(){

        mountTip("PlayList");

        var $playlist = $(this.refs.playList.getDOMNode());
        $playlist.height($(document).height()-202-90-15);


        console.log(  $playlist );
    },
    render : function(){
        var self = this;


        var PlayListItemNodes = this.props.data.playList.map(function(playListDataItem,index){
            return (
                React.createElement(PlayListItem, {key: index, data: playListDataItem, active: self.props.playIndex === index ? true : false})
            );
        });

        return (
            React.createElement("div", {className: "play-list", ref: "playList"}, 
                PlayListItemNodes
            )
        );
    }
});

var PlayListItem = React.createClass({displayName: "PlayListItem",
    render : function(){

        var classes = classNames({
            "play-list-item" : true,
            "active" : this.props.active
        });

        return (
            React.createElement("div", {className: classes}, 
                React.createElement("div", {className: "title"}, 
                    this.props.data.Title
                ), 
                React.createElement("div", {className: "influence"}, 
                    this.props.data.Description
                ), 
                React.createElement("div", {className: "control"}, 
                    React.createElement("div", {className: "control-item left play-button fa fa-play"}), 
                    React.createElement("div", {className: "control-item right play-button fa fa-smile-o"}, "孩子喜欢")
                )
            )
        );
    }
});



/*
* mode
*/

var ModeList = React.createClass({displayName: "ModeList",
    getInitialState: function() {
        return {};
    },
    handleSwitchMode : function(modeKey){

        this.props.onSwitchMode(modeKey);
    },
    componentDidMount : function(){

        mountTip("ModeList");
    },
    render : function(){
        var self = this;

        var ModeListItemNodes = [];

        var widthPersent = 1 / Object.keys(self.props.data).length * 100;

        for (var modeKey in self.props.data)
        {

            var active = false;

            if (modeKey === self.props.modeKey)
            {
                active = true;
            }

            ModeListItemNodes.push(
                React.createElement(ModeListItem, {data: self.props.data[modeKey], active: active, modeKey: modeKey, key: modeKey, onSwitchMode: self.handleSwitchMode, width: widthPersent})
            );
        }

        return (
            React.createElement("div", {className: "mode-list"}, 
                ModeListItemNodes
            )
        );
    }
});

var ModeListItem = React.createClass({displayName: "ModeListItem",
    switchMode : function(){
        this.props.onSwitchMode(this.props.modeKey);
    },

    render : function(){
        var style = {
            width : this.props.width + "%"
        };


        var classes = classNames({
            'mode-list-item' : true,
            'active' : this.props.active
        });

        return(
            React.createElement("div", {className: classes, onClick: this.switchMode, style: style}, 
                React.createElement("div", {className: "mode-icon fa fa-connectdevelop"}), 
                React.createElement("div", {className: "mode-name"}, 
                    this.props.data.title, "模式"
                )
            )
        );
    }
});


/*
* render
* */

var PlayerContainerInstance = React.render(
    React.createElement(PlayerContainer, {dataUrl: "../data/playlist.json", initData: testData}),
    document.getElementById("player")
);

/*webkit message*/
var sendMessage2WKWebkit = function(data){

    //debug
    console.log("sendMessage2WKWebkit : ");
    for(var key in data)
    {
        console.log(key + " : " + data[key]);
    }
    console.log("------------------------");

    if (window.webkit)
    {
        window.webkit.messageHandlers.MVPnotification.postMessage(data);
    }
};

/*
* WKWebkit API
* */

var setPlayList = function(playlistData){
    PlayerContainerInstance.setState({playListData : playlistData});
};

var playIndex = function(index){
    PlayerContainerInstance.setState({playIndex : index});
};