/**
 * Created by bijiabo on 15/4/20.
 */


/*
* play list
*/
var mountTipString = function(componentName){
    return "[ "+componentName+" ] did mount.";
};

var mountTip = function(compneentName){
    console.log(mountTipString(compneentName));
};

var playListIndex = 0;
var activeMode = "normal";

/*
 * container
 * */
var PlayerContainer = React.createClass({displayName: "PlayerContainer",
    getInitialState: function() {
        return {
            playListData : {
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
                        }
                    ]
                }
            }
        };
    },
    componentDidMount : function(){
        var self = this;
        $.getJSON(this.props.dataUrl,{},function(playListData){
            self.setState({
                playListData:playListData,
            });
        });
        mountTip("PlayContainer");
    },
    render : function(){
        return (
            React.createElement("div", {className: "player-container"}, 
                React.createElement(PlayList, {data: this.state.playListData}), ",", 
                React.createElement(ModeList, {data: this.state.playListData}), ","
            )
        )
    }
});



/*
* play list
* */

var PlayList = React.createClass({displayName: "PlayList",
    getInitialState: function() {
        return {
            playList : [],
            activeIndex : 0
        };
    },
    componentDidMount : function(){

        mountTip("PlayList");
    },
    render : function(){

        var PlayListItemNodes = this.props.data[activeMode].playList.map(function(playListDataItem,index){
            return (
                React.createElement(PlayListItem, {key: index})
            );
        });

        return (
            React.createElement("div", {className: "play-list"}, 
                PlayListItemNodes
            )
        );
    }
});

var PlayListItem = React.createClass({displayName: "PlayListItem",
    render : function(){
        return (
            React.createElement("div", {className: "play-list-item"}, 
                "i am play list item"
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
        activeMode = modeKey;

        this.setState({
            playList:this.state.playList,
            modeKey:modeKey
        });
    },
    componentDidMount : function(){
        var self = this;

        mountTip("ModeList");
    },
    render : function(){
        var self = this;

        var ModeListItemNodes = [];

        for (var modeKey in self.state.playList)
        {
            var active = false;

            if (modeKey === self.state.modeKey)
            {
                active = true;
            }

            ModeListItemNodes.push(
                React.createElement(ModeListItem, {data: self.state.playList[modeKey], active: active, modeKey: modeKey, key: modeKey, onSwitchMode: self.handleSwitchMode})
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
        return(
            React.createElement("div", {className: this.props.active?"mode-list-item active":"mode-list-item", onClick: this.switchMode}, 
                this.props.data.title, "模式"
            )
        );
    }
});

/*
* render
* */

React.render(
    React.createElement(PlayerContainer, {dataUrl: "../data/playlist.json"}),
    document.getElementById("player")
);
