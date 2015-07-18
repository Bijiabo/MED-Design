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
var modeData = {
    
}

var ModeList = React.createClass({displayName: "ModeList",
    render : function(){
        return (
            React.createElement("div", {className: "mode-list"}, 
                React.createElement(ModeListItem, null)
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
                "this is mode list item."
            )
        );
    }
});

React.render(
    React.createElement(ModeList, null),
    document.getElementById("modelist")
);
