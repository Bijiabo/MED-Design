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
    render : function(){
        var ModeListItemNodes = modeData.map(function(modeDataItem,index){
            var active = false;
            if (index == modeActiveIndex)
            {
                active = true;
            }
            return (
                React.createElement(ModeListItem, {data: modeDataItem, active: active, key: index})
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
        console.log(this.props.key);
        return(
            React.createElement("div", {className: this.props.active?"mode-list-item active":"mode-list-item", onClick: this.switchMode}, 
                this.props.data.name, "模式"
            )
        );
    }
});

React.render(
    React.createElement(ModeList, null),
    document.getElementById("modelist")
);
