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
        key : "beforeSleep",
        name : "睡前"
    },
    {
        key : "eating",
        name : "吃饭"
    },
    {
        key : "outdoor",
        name : "户外"
    }
];

var modeActiveIndex = 0;

var ModeList = React.createClass({displayName: "ModeList",
    render : function(){
        var ModeListItemNodes = modeData.map(function(modeDataItem,index){
            console.log(index);
            return (
                React.createElement(ModeListItem, {data: modeDataItem})
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
    },
    render : function(){
        return(
            React.createElement("div", {className: "mode-list-item", onClick: this.switchMode}, 
                this.props.data.name, "模式"
            )
        );
    }
});

React.render(
    React.createElement(ModeList, null),
    document.getElementById("modelist")
);
