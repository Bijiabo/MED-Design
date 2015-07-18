/**
 * Created by bijiabo on 15/4/8.
 */
var cache = {
    mode : "normal"
};
var setPlayList = function(playlistData){
    cache.playList = playlistData;

    renderList();
};

var changeMode = function(){
    renderList();
};

var renderList = function(){
    if (cache.playList)
    {
        if (cache.playList[cache.mode])
        {
            var playlistNow = cache.playList[cache.mode].playList;
            var playListHtmlCache = "";
            for (var i= 0,len = playlistNow.length;i<len;i++)
            {
                playListHtmlCache += "<tr data-index=\"" + i + "\"><td>" + playlistNow[i].Title + "</td> <td>" + playlistNow[i].PlayCount + "</td></tr>";
                playListHtmlCache += "<tr data-index=\"" + i + "\"><td>" + playlistNow[i].Description + "</td><td></td></tr>";
            }

            $("#playlistbody").html(playListHtmlCache);
            playIndex(0);
        }
    }
};

var renderModeList = function(){
    var htmlCache = "";
    for (modeItem in cache.playList)
    {
        htmlCache += '<li><a data-mode="' + modeItem + '">' + cache.playList[modeItem].title + '</a></li>';
    }

    $("#mode-switch").html(htmlCache);
};

var sendMessage2WKWebkit = function(data){
    if (window.webkit)
    {
        window.webkit.messageHandlers.MVPnotification.postMessage(data);
    }
};

var playIndex = function (index) {
    $('#playlist tr').removeClass("active");
    $('#playlist tr[data-index="'+index+'"]').addClass("active");
};

$(function()
{

    $(document).on("click","#mode-switch li a",function(event){

        switch ($(event.target).text())
        {
            case "平时":
                cache.mode = "normal";
                break;

            case "起床":
                cache.mode = "getup";
                break;

            case "睡前":
                cache.mode = "sleep";
                break;

            default :
        }
        changeMode();

        sendMessage2WKWebkit({
            action: "changeMode",
            mode : cache.mode
        });
    });

    $(document).on("click","#playbutton",function(event){
        sendMessage2WKWebkit({
            action : "switchPlayPause"
        });
    });

});