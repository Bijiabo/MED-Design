/**
 * Created by bijiabo on 15/8/27.
 */
var generateNavigationHtml = function (data) {
  var siteIconTemplate = $("#navigation-container .row#normail-item");
  var siteIconAddTemplate = $("#navigation-container .row#add-item");

  var htmlString = "";

  for (var i= 0,len=data.length; i<len; i++) {
    siteIconTemplate.find(".site-name").text(data[i].name);
    siteIconTemplate.find("a").attr("href",data[i].url);

    htmlString += siteIconTemplate.html();
  }

  htmlString += siteIconAddTemplate.html();

  return htmlString;
};

$(function () {
  $("#navigation-container").html( generateNavigationHtml(navigationData) );
});
