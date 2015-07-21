//
//  shopDetailViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/18.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class shopDetailViewController: UIViewController , UIScrollViewDelegate
{

    @IBOutlet var backButton: UIButton!
    @IBOutlet var Container: UIView!
    @IBOutlet var scrollView: UIScrollView!
    
    var PlayerViewController: AVPlayerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.addTarget(self, action: Selector("back"), forControlEvents: UIControlEvents.TouchUpInside)
        
        InitScrollView()
    }
    
    override func viewWillAppear(animated: Bool) {
        let VideoURL : NSURL = NSBundle.mainBundle().resourceURL!.URLByAppendingPathComponent("video/lego_buy.mp4")
        PlayerViewController.player = AVPlayer(URL: VideoURL)
        
        PlayerViewController.player.volume = 0.0
        
        //PlayerViewController.player.play()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("avplayerDidFinishPlay"), name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func back()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func InitScrollView()
    {
        scrollView.delegate = self
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2.0)
        
        scrollView.scrollEnabled = true
        
        scrollView.pagingEnabled = false
        
        var shopDetailVC : shopDetailContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("shopDetailContentVC") as! shopDetailContentViewController
        
        shopDetailVC.view.frame = self.view.frame
        shopDetailVC.view.frame.origin.y = self.view.frame.size.height - 200
        shopDetailVC.view.frame.size.height = self.view.frame.size.height + 200

        shopDetailVC.view.backgroundColor = UIColor.clearColor()
        
        
        self.addChildViewController( shopDetailVC )
        self.scrollView.addSubview( shopDetailVC.view )
    }

    func avplayerDidFinishPlay()
    {
        //PlayerViewController.player.seekToTime(CMTimeMake(0, 1000))
        
        //PlayerViewController.player.play()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "containerToAVPlayer"
        {
            PlayerViewController = segue.destinationViewController as! AVPlayerViewController
        }
    }

    
    // MARK: scroll view delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
    }

}
