//
//  DPlayer.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/4/12.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit

class DPlayer : NSObject {
  var player : AVPlayer!
  var playerObserver :  AnyObject!
  var mediaResourceURL : NSURL!
  var playList : JSON!
  var playMode : String = "normal"
  var playListIndex : Int = 0
  var playerEndObserver : AnyObject!
  var playTimes : Int = 0
  
  var sessionError : NSError!
  
  var dev : Bool = false
  
  override init(){
    super.init()
    
    let paths : NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let documentsDirectory : NSString = paths.objectAtIndex(0) as! NSString
    var resourcePath : NSURL = NSURL(fileURLWithPath: documentsDirectory.stringByAppendingPathComponent("web/media/"))
    
    if dev
    {
      let baseURL: NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath)
      resourcePath = baseURL.URLByAppendingPathComponent("web/media/")
    }
    
    mediaResourceURL = resourcePath
    
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, withOptions: AVAudioSessionCategoryOptions.DefaultToSpeaker)
    } catch _ {
    }
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleInterruption:", name: AVAudioSessionInterruptionNotification, object: AVAudioSession.sharedInstance())
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleMediaServicesReset", name: AVAudioSessionMediaServicesWereResetNotification, object: AVAudioSession.sharedInstance())
  }
  
  func setPlayerResourceByName (fileName fileName:String) -> Void
  {
    NSNotificationCenter.defaultCenter().removeObserver(AVPlayerItemDidPlayToEndTimeNotification)
    
    player = AVPlayer(URL: mediaResourceURL.URLByAppendingPathComponent(fileName))
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd", name: AVPlayerItemDidPlayToEndTimeNotification , object: player.currentItem)
  }
  
  func setPlayerResourceList (mode mode : String) -> Void
  {
    NSNotificationCenter.defaultCenter().removeObserver(AVPlayerItemDidPlayToEndTimeNotification)
    
    playMode = mode
    playIndex(0)
    playTimes = 0
    
    player = AVPlayer(URL: mediaResourceURL.URLByAppendingPathComponent( playList[playMode]["playList"][0]["Url"].stringValue ))
    
    //player.seekToTime(CMTimeMake(60*3*1000, 1000))
    
    player.play()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd", name: AVPlayerItemDidPlayToEndTimeNotification , object: player.currentItem)
  }
  
  func playerItemDidReachEnd(){
    var playNext : Bool = false
    
    if playList[playMode]["playList"][playIndex()]["PlayCount"].intValue > 0
    {
      if playTimes < playList[playMode]["playList"][playIndex()]["PlayCount"].intValue - 1
      {
        print("play Times add")
        
        playTimes += 1
      }
      else
      {
        playNext = true
      }
    }
    else
    {
      playNext = true
    }
    
    if playNext
    {
      playTimes = 0
      
      if playIndex() + 1 <= playList[playMode]["playList"].count - 1
      {
        playIndexAdd(1)
      }
      else
      {
        playIndex(0)
      }
    }
    
    
    let nextPlayItem = playList[playMode]["playList"][playIndex()]
    
    player = AVPlayer(URL: mediaResourceURL.URLByAppendingPathComponent( nextPlayItem["Url"].stringValue ))
    player.play()
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerItemDidReachEnd", name: AVPlayerItemDidPlayToEndTimeNotification , object: player.currentItem)
  }
  
  func playIndex(index : Int? = nil) -> Int {
    if (index != nil)
    {
      playListIndex = index!
      
      NSNotificationCenter.defaultCenter().postNotificationName("Notification_changePlayIndex", object: ["playIndex" : playListIndex], userInfo: nil)
    }
    return playListIndex
  }
  
  func playIndexAdd(number : Int? = 1) -> Int {
    if number != nil
    {
      playListIndex += number!
    }
    else
    {
      playListIndex += 1
    }
    NSNotificationCenter.defaultCenter().postNotificationName("Notification_changePlayIndex", object: ["playIndex" : playListIndex], userInfo: nil)
    return playListIndex
  }
  
  func handleInterruption(notification : NSNotification) -> Void
  {
    if let userInfo : NSDictionary = notification.userInfo
    {
      let interruptionType : NSNumber = userInfo.objectForKey(AVAudioSessionInterruptionTypeKey) as! NSNumber

      let interruptionOption : NSNumber = userInfo.objectForKey(AVAudioSessionInterruptionOptionKey) as! NSNumber

      switch interruptionType.unsignedIntegerValue
      {
      case Int(AVAudioSessionInterruptionType.Began.rawValue):
        break
      case Int(AVAudioSessionInterruptionType.Ended.rawValue):
        if interruptionOption.unsignedIntegerValue == Int(AVAudioSessionInterruptionOptions.OptionShouldResume.rawValue)
        {
          self.player.play()
        }
      default:
        break
      }
    }
  }
  
}