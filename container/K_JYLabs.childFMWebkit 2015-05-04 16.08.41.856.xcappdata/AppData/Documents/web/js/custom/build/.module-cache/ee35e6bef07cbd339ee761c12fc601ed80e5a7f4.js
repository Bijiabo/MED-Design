/**
 * Created by bijiabo on 15/4/20.
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