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



}
