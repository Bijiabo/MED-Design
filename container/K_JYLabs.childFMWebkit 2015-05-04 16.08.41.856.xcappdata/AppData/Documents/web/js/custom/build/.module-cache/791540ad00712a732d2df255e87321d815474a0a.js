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


var ModeList = React.createClass({displayName: "ModeList",
    getInitialState: function() {
        return {};
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
            console.log(playListData);
            self.setState({
                playList:playListData,
                activeIndex:0
            });
        });

        mountTip("ModeList");
    },
    render : function(){
        var self = this;

        var ModeListItemNodes = [];

        for (var modeKey in self.state.playList)
        {
            console.log(modeKey);
        }

        /*
        var ModeListItemNodes = this.props.data.map(function(modeDataItem,index){
            var active = false;

            if (index === self.state.active)
            {
                active = true;
            }
            return (
                <ModeListItem data={{data:modeDataItem,index:index}} active={active} key={index} onSwitchMode={self.handleSwitchMode}/>
            )
        });
        */

        return (
            React.createElement("div", {className: "mode-list"}, 
                ModeListItemNodes
            )
        );
    }
});

var ModeListItem = React.createClass({displayName: "ModeListItem",
    switchMode : function(){
        modeActiveIndex = this.props.data.index;

        this.props.onSwitchMode(this.props.data.index);
    },

    render : function(){
        return(
            React.createElement("div", {className: this.props.active?"mode-list-item active":"mode-list-item", onClick: this.switchMode}, 
                this.props.data.data.name, "模式"
            )
        );
    }
});

React.render(
    React.createElement(ModeList, {data: modeData, active: modeActiveIndex, dataUrl: "../data/playlist.json"}),
    document.getElementById("modelist")
);
