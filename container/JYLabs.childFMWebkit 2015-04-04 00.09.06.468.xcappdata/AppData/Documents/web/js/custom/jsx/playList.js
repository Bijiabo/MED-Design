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
var PlayerContainer = React.createClass({
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
                modeKey:modeKey,
                playIndex:0
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
            <div className="player-container">
                <PlayerChart />

                <PlayList data={this.state.playListData[this.state.modeKey]} modeKey={this.state.modeKey} playIndex={this.state.playIndex}/>

                <ModeList data={this.state.playListData} onSwitchMode={this.handleSwitchMode} modeKey={this.state.modeKey}/>
            </div>
        )
    }
});

var PlayerChart = React.createClass({
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
            <div className="player-chart">
                <canvas id="myChart" width="200" height="200"></canvas>
            </div>
        );
    }
});


/*
* play list
* */

var PlayList = React.createClass({
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
                <PlayListItem key={index} data={playListDataItem} active={self.props.playIndex === index ? true : false}/>
            );
        });

        return (
            <div className="play-list" ref="playList">
                {PlayListItemNodes}
            </div>
        );
    }
});

var PlayListItem = React.createClass({
    render : function(){

        var classes = classNames({
            "play-list-item" : true,
            "active" : this.props.active
        });

        return (
            <div className={classes}>
                <div className="title">
                    {this.props.data.Title}
                </div>
                <div className="influence">
                    {this.props.data.Description}
                </div>
                <div className="control">
                    <div className="control-item left play-button fa fa-play"></div>
                    <div className="control-item right play-button fa fa-smile-o">
                        <div className="text">孩子喜欢</div>
                    </div>
                </div>
            </div>
        );
    }
});



/*
* mode
*/

var ModeList = React.createClass({
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
                <ModeListItem data={self.props.data[modeKey]} active={active} modeKey={modeKey} key={modeKey} onSwitchMode={self.handleSwitchMode} width={widthPersent}/>
            );
        }

        return (
            <div className="mode-list">
                {ModeListItemNodes}
            </div>
        );
    }
});

var ModeListItem = React.createClass({
    switchMode : function(){
        console.log("switch mode clicked");

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
            <div className={classes} onClick={this.switchMode} style={style}>
                <div className="mode-icon fa fa-connectdevelop"></div>
                <div className="mode-name">
                    {this.props.data.title}模式
                </div>
            </div>
        );
    }
});


/*
* render
* */

var PlayerContainerInstance = React.render(
    <PlayerContainer dataUrl="../data/playlist.json" initData={testData}/>,
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
    PlayerContainerInstance.setState({
        playListData : playlistData,
        playIndex : 0
    });
};

var playIndex = function(index){
    PlayerContainerInstance.setState({playIndex : index});
};