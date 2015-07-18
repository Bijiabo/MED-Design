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

/*
 * container
 * */
var PlayerContainer = React.createClass({displayName: "PlayerContainer",
    render : function(){
        return (
            React.createElement("div", {className: "player-container"}, 
                React.createElement(PlayList, null)
            )
        )
    }
});

/*
* play list
* */
var playListIndex = 0;

var PlayList = React.createClass({displayName: "PlayList",
    getInitialState: function() {
        return {
            playList : [],
            activeIndex : 0
        };
    },
    componentDidMount : function(){
        var self = this;
        $.getJSON(this.props.dataUrl,{},function(playListData){
            self.setState({
                playList:playListData[activeMode].playList,
                activeIndex : self.state.activeIndex
            });
        });
        mountTip("PlayList");
    },
    render : function(){

        var PlayListItemNodes = this.state.playList.map(function(playListDataItem,index){
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

React.render(
    React.createElement(PlayList, {dataUrl: "../data/playlist.json"}),
    document.getElementById("playlist")
);

/*
* mode
*/
var modeData = [
    {
        id : "beforeSleep",
        name : "睡前"
    },
    {
        id : "eating",
        name : "吃饭"
    },
    {
        id : "outdoor",
        name : "户外"
    }
];


var modeActiveIndex = 0;
var activeMode = "normal";

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

        $.getJSON(this.props.dataUrl,{},function(playListData){
            self.setState({
                playList:playListData,
                modeKey:"normal"
            });
        });

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

React.render(
    React.createElement(ModeList, {dataUrl: "../data/playlist.json"}),
    document.getElementById("modelist")
);
