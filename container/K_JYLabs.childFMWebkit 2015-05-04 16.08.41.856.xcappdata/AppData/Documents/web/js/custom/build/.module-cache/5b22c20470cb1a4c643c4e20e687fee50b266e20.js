/**
 * Created by bijiabo on 15/4/20.
 */

/*
* play list
*/

var PlayList = React.createClass({displayName: "PlayList",
    render : function(){
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
    React.createElement(PlayList, null),
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
        return {activeIndex: 0};
    },
    render : function(){
        var self = this;
        var ModeListItemNodes = this.props.data.map(function(modeDataItem,index){
            var active = false;
            console.log(self.props.active);

            if (index === self.props.active)
            {
                active = true;
            }
            return (
                React.createElement(ModeListItem, {data: {data:modeDataItem,index:index}, active: active, key: index})
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
        console.log("switch mode");
        modeActiveIndex = this.props.data.index;
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
    React.createElement(ModeList, {data: modeData, active: modeActiveIndex}),
    document.getElementById("modelist")
);
