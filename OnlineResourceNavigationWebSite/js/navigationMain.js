/**
 * Created by bijiabo on 15/8/27.
 */
var generateNavigationHtml = function (data) {
  var siteIconTemplate = $("#navigation-container .row#normail-item");
  var siteIconAddTemplate = $("#navigation-container .row#add-item");

  var htmlString = "";

  for (var i= 0,len=data.length; i<len; i++) {
    siteIconTemplate.find(".site-name").text(data[i].name);
    siteIconTemplate.find(".site-icon img").attr("src", "images/" + data[i].image);
    siteIconTemplate.find("a").attr("href",data[i].url);

    htmlString += siteIconTemplate.html();
  }

  htmlString += siteIconAddTemplate.html();

  return htmlString;
};

var addIconItem = function() {
  var siteIconTemplate = $('<div><div class="site-item col-xs-4">' +   $("#navigation-container .site-item").html() + '</div></div>' );

  $("#navigation-container .site-item-add").before(siteIconTemplate.html());
};

var showShadow = function () {
  if ($('#shadow').length === 0) {
    $('body').append('<div id="shadow" style="display: none;"></div>');
  }
  $('#shadow').fadeIn();
};

var hideShadow = function () {
  $('#shadow').fadeOut();
};

$(function () {
  $("#navigation-container").html( generateNavigationHtml(navigationData) );
});
