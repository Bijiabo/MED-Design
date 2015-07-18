/**
 * Created by bijiabo on 15/4/20.
 */
React.initializeTouchEvents(true);

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
                    "title" : "",
                    "playList" : []
                }
            },
            modeKey : activeMode
        };
    },
    handleSwitchMode : function(modeKey){
        activeMode = modeKey;

        this.setState({
            modeKey:modeKey
        });
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
                React.createElement(PlayList, {data: this.state.playListData}), 
                React.createElement("hr", null), 
                React.createElement(ModeList, {data: this.state.playListData, onSwitchMode: this.handleSwitchMode})
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
            activeIndex : 0
        };
    },
    componentDidMount : function(){

        mountTip("PlayList");
    },
    render : function(){

        var PlayListItemNodes = this.props.data[activeMode].playList.map(function(playListDataItem,index){
            return (
                React.createElement(PlayListItem, {key: index, data: playListDataItem})
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
                this.props.data.Title
            )
        );
    }
});



/*
* mode
*/

var ModeList = React.createClass({displayName: "ModeList",
    getInitialState: function() {
        return {modeKey : modeKey};
    },
    handleSwitchMode : function(modeKey){
        this.setState({
            modeKey : modeKey
        });

        this.props.onSwitchMode(modeKey);
    },
    componentDidMount : function(){

        mountTip("ModeList");
    },
    render : function(){
        var self = this;

        var ModeListItemNodes = [];

        for (var modeKey in self.props.data)
        {

            var active = false;

            if (modeKey === self.state.modeKey)
            {
                active = true;
            }

            ModeListItemNodes.push(
                React.createElement(ModeListItem, {data: self.props.data[modeKey], active: active, modeKey: modeKey, key: modeKey, onSwitchMode: self.handleSwitchMode})
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

var PlayerContainerInstance = React.render(
    React.createElement(PlayerContainer, {dataUrl: "../data/playlist.json"}),
    document.getElementById("player")
);
