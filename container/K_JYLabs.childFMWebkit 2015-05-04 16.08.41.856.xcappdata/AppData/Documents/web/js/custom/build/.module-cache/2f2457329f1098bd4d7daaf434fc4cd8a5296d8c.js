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
                React.createElement(PlayerChart, null), 
                React.createElement("hr", null), 
                React.createElement(PlayList, {data: this.state.playListData, modeKey: this.state.modeKey}), 
                React.createElement("hr", null), 
                React.createElement(ModeList, {data: this.state.playListData, onSwitchMode: this.handleSwitchMode, modeKey: this.state.modeKey})
            )
        )
    }
});

var PlayerChart = React.createClass({displayName: "PlayerChart",
    componentDidMount : function(){

        mountTip("Player Chart");

        var data = [
            {
                value: 300,
                color:"#F7464A",
                highlight: "#FF5A5E",
                label: "Red"
            },
            {
                value: 50,
                color: "#46BFBD",
                highlight: "#5AD3D1",
                label: "Green"
            },
            {
                value: 100,
                color: "#FDB45C",
                highlight: "#FFC870",
                label: "Yellow"
            },
            {
                value: 40,
                color: "#949FB1",
                highlight: "#A8B3C5",
                label: "Grey"
            },
            {
                value: 120,
                color: "#4D5360",
                highlight: "#616774",
                label: "Dark Grey"
            }

        ];

        // Get context with jQuery - using jQuery's .get() method.
        var ctx = $("#myChart").get(0).getContext("2d");
        // This will get the first returned node in the jQuery collection.
        new Chart(ctx).Pie(data, {
            scaleShowLabelBackdrop : false,
            segmentShowStroke : true,
            segmentStrokeWidth : 4,
            segmentStrokeColor: "#ffffff",
            scaleShowLine : false,
            animationSteps : 50,
            scaleShowLabels : false,
            percentageInnerCutout:0,
            scaleBeginAtZero: false,
            animateScale: true,
            animateRotate : true,
            showScale:false
        });

    },
    render : function(){
        return(
            React.createElement("div", {className: "player-chart"}, 
                React.createElement("canvas", {id: "myChart", width: "400", height: "400"})
            )
        );
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

        var PlayListItemNodes = this.props.data[this.props.modeKey].playList.map(function(playListDataItem,index){
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
        return {};
    },
    handleSwitchMode : function(modeKey){

        this.props.onSwitchMode(modeKey);
    },
    componentDidMount : function(){

        mountTip("ModeList");
    },
    render : function(){
        var self = this;

        var ModeListItemNodes = [];

        var widthPersent = 1 / self.props.data.length;

        for (var modeKey in self.props.data)
        {

            var active = false;

            if (modeKey === self.props.modeKey)
            {
                active = true;
            }

            ModeListItemNodes.push(
                React.createElement(ModeListItem, {data: self.props.data[modeKey], active: active, modeKey: modeKey, key: modeKey, onSwitchMode: self.handleSwitchMode, width: widthPersent})
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




/*

$(function(){
    var data = {
        labels: ["January", "February", "March", "April", "May", "June", "July"],
        datasets: [
            {
                label: "My First dataset",
                fillColor: "rgba(220,220,220,0.2)",
                strokeColor: "rgba(220,220,220,1)",
                pointColor: "rgba(220,220,220,1)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                data: [65, 59, 80, 81, 56, 55, 40]
            },
            {
                label: "My Second dataset",
                fillColor: "rgba(151,187,205,0.2)",
                strokeColor: "rgba(151,187,205,1)",
                pointColor: "rgba(151,187,205,1)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(151,187,205,1)",
                data: [28, 48, 40, 19, 86, 27, 90]
            }
        ]
    };

// Get context with jQuery - using jQuery's .get() method.
    var ctx = $("#myChart").get(0).getContext("2d");
// This will get the first returned node in the jQuery collection.
    new Chart(ctx).Line(data, {
        bezierCurve: false
    });
});
*/