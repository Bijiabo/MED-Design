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
* play list
* */
var playListIndex = 0;

var PlayList = React.createClass({displayName: "PlayList",
    getInitialState: function() {
        return {
            playList : {},
            activeIndex : 0
        };
    },
    componentDidMount : function(){
        var self = this;
        $.getJSON(this.props.dataUrl,{},function(playListData){
            self.setState({
                playList:playListData,
                activeIndex:0
            });
        });

        mountTip("PlayList");
    },
    render : function(){
        console.log(this.state.playList[modeActiveIndex]);
        /*
        var PlayListItemNodes = this.state.playList[modeActiveIndex].map(function(playListDataItem,index){
            return (
                <PlayListItem />
            );
        });
        */
        return (
            React.createElement("div", {className: "play-list"}, 
                React.createElement(PlayListItem, null)
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


var modeActiveIndex = 0;
var activeMode = "normal";

var ModeList = React.createClass({displayName: "ModeList",
    getInitialState: function() {
        return {
            playList : {},
            activeMode : 0
        };
    },
    handleSwitchMode : function(modeIndex){
        modeActiveIndex = modeIndex;

        this.setState({
            active: modeIndex
        });
    },
    componentDidMount : function(){
        var self = this;
        $.getJSON(this.props.dataUrl,{},function(playListData){
            self.setState({
                playList:playListData,
                activeIndex:0
            });
        });

        mountTip("ModeList");
    },
    render : function(){
        var self = this;
        var ModeListItemNodes = this.state.playList.map(function(modeDataItem,index){
            var active = false;

            if (index === self.state.active)
            {
                active = true;
            }
            return (
                React.createElement(ModeListItem, {data: {data:modeDataItem}, active: active, key: index, onSwitchMode: self.handleSwitchMode})
            )

        });
        return (
            React.createElement("div", {className: "mode-list"}, 
                ModeListItemNodes
            )
        );
    }
});

var ModeListItem = React.createClass({displayName: "ModeListItem",
    switchMode : function(){
        this.props.onSwitchMode(this.props.data.id);
    },

    render : function(){
        return(
            React.createElement("div", {className: this.props.active?"mode-list-item active":"mode-list-item", onClick: this.switchMode}, 
                this.props.data.data.title
            )
        );
    }
});

React.render(
    React.createElement(ModeList, {data: modeData, active: modeActiveIndex}),
    document.getElementById("modelist")
);
