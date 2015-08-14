//
//  mvpViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/4/8.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit
import WebKit

class mvpViewController: UIViewController ,WKNavigationDelegate {
  
  let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
  var webView : WKWebView!
  var userContentController : WKUserContentController!
  var configuration : WKWebViewConfiguration!
  var dev : Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let handler = mvpNotificationScriptMessageHandler(viewController: self)
    userContentController = WKUserContentController()
    userContentController.addScriptMessageHandler(handler, name: "MVPnotification")
    
    configuration = WKWebViewConfiguration()
    configuration.userContentController = userContentController
    
    
    webView = WKWebView(frame: view.frame, configuration: configuration)
    
    let baseURL: NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath)
    var requestUrl : NSURL! = baseURL.URLByAppendingPathComponent("web/html/playList.html")

    if !dev
    {
      requestUrl = NSURL(string:  "http://127.0.0.1:8080/html/playList.html")
    }
    else
    {
      requestUrl = NSURL(string:  "http://10.0.0.206/DDT/html/playList.html")
    }
    
    let localReq = NSURLRequest(URL:requestUrl)
    
    webView?.loadRequest(localReq)
    
    self.view = webView
    webView.navigationDelegate = self
    
    //接收音频切换通知
    NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("playIndexChanged:") , name: "Notification_changePlayIndex", object: nil)
    
    
    UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
    becomeFirstResponder()
    
  }
  
  override func viewWillDisappear(animated: Bool) {
    UIApplication.sharedApplication().endReceivingRemoteControlEvents()
    resignFirstResponder()
    
    super.viewWillDisappear(animated)
  }
  
  func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    //通知页面已加载完成，执行 js<->swift 数据
    //json
    let paths : NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let documentsDirectory : NSString = paths.objectAtIndex(0) as! NSString
    let dataPath : NSURL = NSURL(fileURLWithPath: documentsDirectory.stringByAppendingPathComponent("web/data/playlist.json"))
    /*
    if dev
    {
      let baseURL: NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath)!
      dataPath = baseURL.URLByAppendingPathComponent("web/data/playlist.json")
    }
    */
    
    let playlistNSData : NSData = NSData(contentsOfURL: dataPath)!
    
    let playlistJSONData : JSON = JSON(data: playlistNSData, options: NSJSONReadingOptions.MutableContainers, error: nil)
    
//    appDelegate.player.playList =  playlistJSONData
//    appDelegate.player.setPlayerResourceList(mode: "normal")
    
    webView.evaluateJavaScript("setPlayList(\(playlistJSONData));", completionHandler: nil)
  }
  
  func playIndexChanged(notification: NSNotification){
    print("playIndexChanged")
    
    let object = notification.object as! Dictionary<String,Int>
    let playIndex : Int = object["playIndex"]!

    ///*
    webView.evaluateJavaScript("playIndex(\(playIndex));", completionHandler: {(AnyObject, NSError) in
      print("send playIndex change to view complete")
    })
    //*/
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
}

class mvpNotificationScriptMessageHandler: NSObject, WKScriptMessageHandler
{
  var vc : AnyObject!
  let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
  
  init(viewController : AnyObject) {
    vc = viewController
  }
  
  func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage)
  {
    
    if let action = message.body["action"] as? String
    {
      switch action
      {
      case "changeMode":
        print("changeMode...")
        
        if let _ = message.body["mode"] as? String
        {
//          appDelegate.player.setPlayerResourceList(mode : viewChangeMode)
          
//          appDelegate.player.player.play()
          
        }
        
        
      case "switchPlayPause":
        let play : Bool = true;
        play.boolValue
        /*
        if (appDelegate.player.player.rate>0 && appDelegate.player.player.currentItem != nil)
        {
          play = false
          appDelegate.player.player.pause()
        }
        else
        {
          appDelegate.player.player.play()
        }
        */
        vc.webView!.evaluateJavaScript("setPlayState(\(String(stringInterpolationSegment: play.boolValue)));", completionHandler: nil)
        
      default:
        print("")
      }
      
    }
    
  }
  
  func canBecomeFirstResponder() -> Bool{
    return true
  }
  
  func remoteControlReceivedWithEvent(receivedEvent : UIEvent) -> Void
  {
    if receivedEvent.type == UIEventType.RemoteControl
    {
      switch receivedEvent.subtype
      {
      case UIEventSubtype.RemoteControlTogglePlayPause:
          print("toggle play pr pause")
        
      case UIEventSubtype.RemoteControlPreviousTrack:
        print("previous track")
        
      default:
        break
      }
    }
  }
}


