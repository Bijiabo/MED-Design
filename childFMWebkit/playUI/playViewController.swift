//
//  playViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/16.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class playViewController: UIViewController , DemoModule , PlayUI
{
    let DebugMode : Bool = true
    
    var operation : Operations?
    
    var VideoFileName : String = "pirate.mp4"
    {
        didSet{
            let VideoURL : NSURL = NSBundle.mainBundle().resourceURL!.URLByAppendingPathComponent("video/\(VideoFileName)")
            PlayerViewController.player = AVPlayer(URL: VideoURL)
            
            PlayerViewController.player.volume = 0.0
            
            PlayerViewController.player.play()
        }
    }
    
    var navigationDelegate : NavigationProtocol?
    
    var PlayerViewController: AVPlayerViewController!
    
    @IBOutlet var container: UIView!
    @IBOutlet var FakeNavigationBar: UINavigationBar!
    @IBOutlet var FakeNavigationBarTitle: UINavigationItem!
    @IBOutlet var AudioName: UILabel!
    @IBOutlet var AudioTag: UILabel!
    @IBOutlet var GiftTipCount: UILabel!
    @IBOutlet var childLikeButton: UIButton!
    @IBOutlet var childDislikeButton: UIButton!
    @IBOutlet var playPauseSwitchButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init the fake navigation bar
        _InitFakeNavigationBar()

        let VideoURL : NSURL = NSBundle.mainBundle().resourceURL!.URLByAppendingPathComponent("video/\(VideoFileName)")
        PlayerViewController.player = AVPlayer(URL: VideoURL)
        
        PlayerViewController.player.volume = 0.0
        
        //video size is 640x360
        
        let videoHeight : CGFloat = PlayerViewController.view.frame.size.height
        let videoWidth : CGFloat = videoHeight / 9 * 16 * 2
        
        //PlayerViewController.view.layer.frame = CGRectMake(0 - (videoWidth - self.view.frame.size.width) / 2 + 100 , 0 , videoWidth, videoHeight)
        
        PlayerViewController.player.play()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("avplayerDidFinishPlay"), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("AppDidBecomeActive:"), name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    func AppDidBecomeActive (notification : NSNotification)
    {
        PlayerViewController.player.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if PlayerViewController.player != nil
        {
            PlayerViewController.player.play()
        }
    }
    
    func avplayerDidFinishPlay()
    {
        PlayerViewController.player.seekToTime(CMTimeMake(0, 1000))
        
        PlayerViewController.player.play()
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "embedding")
        {
            PlayerViewController = segue.destinationViewController as! AVPlayerViewController
        }
    }
    
    // MARK: init func
    
    private func _InitFakeNavigationBar ()
    {

        FakeNavigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor(red:1, green:1, blue:1, alpha:0.6)
        ]
        
        FakeNavigationBarTitle.title = "玩耍磨耳朵"
        
        FakeNavigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
        FakeNavigationBar.shadowImage = UIImage()

    }
    
    // MARK: user tap button
    @IBAction func tapChildLikeButton(sender: AnyObject) {
        
        if childLikeButton.alpha != 1.0
        {
            childLikeButton.alpha = 1.0
            childDislikeButton.alpha = 0.5
        }
        else
        {
            childLikeButton.alpha = 0.5
            childDislikeButton.alpha = 0.5
        }
    }
    
    @IBAction func tapChildDislikeButton(sender: AnyObject) {
        if childDislikeButton.alpha != 1.0
        {
            childLikeButton.alpha = 0.5
            childDislikeButton.alpha = 1.0
        }
        else
        {
            childLikeButton.alpha = 0.5
            childDislikeButton.alpha = 0.5
        }
    }

    @IBAction func tapPlayPauseSwitchButton(sender: AnyObject) {
        
        if playPauseSwitchButton.tag != 1
        {
            NSNotificationCenter.defaultCenter().postNotificationName("PlayUIVC_Play", object: self.view.tag)
        }
        else
        {
            NSNotificationCenter.defaultCenter().postNotificationName("PlayUIVC_Pause", object: self.view.tag)
        }
        
    }

    @IBAction func SendTestNotification(sender: AnyObject) {
        
        if DebugMode == false { return }
        /*
        let notification:UILocalNotification = UILocalNotification()
        notification.alertBody = "A test local notification."
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        */
        //NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("sendTestNotification"), userInfo: nil, repeats: false)
        
        sendTestNotification()
    }
    
    
    
    
    func sendTestNotification()
    {
        /*
        let notification:UILocalNotification = UILocalNotification()
        notification.alertBody = "A test local notification."
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        */
        
        // 1. Create the actions **************************************************
        
        // increment Action
        let incrementAction = UIMutableUserNotificationAction()
        incrementAction.identifier = "Switch_Now"
        incrementAction.title = "立即切换"
        incrementAction.activationMode = UIUserNotificationActivationMode.Background
        incrementAction.authenticationRequired = true
        incrementAction.destructive = false
        
        // decrement Action
        let decrementAction = UIMutableUserNotificationAction()
        decrementAction.identifier = "Cancel"
        decrementAction.title = "取消"
        decrementAction.activationMode = UIUserNotificationActivationMode.Background
        decrementAction.authenticationRequired = true
        decrementAction.destructive = false
        
        // reset Action
        let resetAction = UIMutableUserNotificationAction()
        resetAction.identifier = "Close"
        resetAction.title = "关闭"
        resetAction.activationMode = UIUserNotificationActivationMode.Foreground
        // NOT USED resetAction.authenticationRequired = true
        resetAction.destructive = true
        
        // 2. Create the category ***********************************************
        
        // Category
        let counterCategory = UIMutableUserNotificationCategory()
        counterCategory.identifier = "COUNTER_CATEGORY"
        
        // A. Set actions for the default context
        counterCategory.setActions([incrementAction, decrementAction, resetAction],
        forContext: UIUserNotificationActionContext.Default)
        
        // B. Set actions for the minimal context
        counterCategory.setActions([incrementAction, decrementAction],
        forContext: UIUserNotificationActionContext.Minimal)
        
        
        
        let types = UIUserNotificationType.Alert | UIUserNotificationType.Sound
        let settings = UIUserNotificationSettings(forTypes: types, categories: NSSet(object: counterCategory) as Set<NSObject>)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
        
        let notification = UILocalNotification()
        notification.alertBody = "15秒后切换到睡前播放情景"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.fireDate = NSDate()
        notification.category = "COUNTER_CATEGORY"
        notification.repeatInterval = NSCalendarUnit.CalendarUnitMinute
        
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

}
