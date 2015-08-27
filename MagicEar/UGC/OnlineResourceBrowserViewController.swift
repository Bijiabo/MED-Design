//
//  OnlineResourceBrowserViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/8/27.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import UIKit

class OnlineResourceBrowserViewController: UIViewController , UIWebViewDelegate , DownloadView {

    @IBOutlet var webView: UIWebView!
    @IBOutlet var addressBar: UIView!
    @IBOutlet var addressTextField: UITextField!
    
    var audioFileURL : NSURL = NSURL()
    let tipViewTag : Int = 1024
    var URLList : Array<NSURL> = Array<NSURL>()
    var taskList : Array<NSURLSessionDownloadTask> = Array<NSURLSessionDownloadTask>()
    
    var leftBarItemCache : UIBarButtonItem!
    let localNavigationURL = NSBundle.mainBundle().resourceURL!.URLByAppendingPathComponent("OnlineResourceNavigationWebSite/index.html")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optimizeWebkitMemory()
        
        /*
        let requestURLString : String = "http://douban.fm"
        addressTextField.text = requestURLString
        webView.loadRequest(NSURLRequest(URL: NSURL(string: requestURLString)!))
        */
        webView.delegate = self
        webView.loadRequest(NSURLRequest(URL: localNavigationURL))
        addressTextField.text = webView.request?.URL?.absoluteString
        
        _initAddressBar()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("newAudioFileRequest:"), name: "NewAudioFileRequest", object: nil)
        
        NSNotificationCenter.defaultCenter().postNotificationName("NeedDownloadListData", object: self)
        
        leftBarItemCache = tabBarController?.navigationItem.leftBarButtonItem
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        _removeBackButton()
    }
    
    private func _addBackButton() {
        let returnBarButton : UIButton = UIButton(frame: CGRectMake(0.0, 4.0, 12.0, 18.0))
        returnBarButton.setBackgroundImage(UIImage(named: "back"), forState: UIControlState.Normal)
        returnBarButton.addTarget(self, action: Selector("backNavigation"), forControlEvents: UIControlEvents.TouchUpInside)
        let returnBarButtonItem : UIBarButtonItem = UIBarButtonItem(customView: returnBarButton)
        
        let nullButton : UIButton = UIButton(frame: CGRectMake(0.0, 0.0, 6.0, 22.0))
        let nullBarButtonItem : UIBarButtonItem = UIBarButtonItem(customView: nullButton)
        
        tabBarController?.navigationItem.leftBarButtonItems = [returnBarButtonItem , nullBarButtonItem , leftBarItemCache]
    }
    
    private func _removeBackButton() {
        tabBarController?.navigationItem.leftBarButtonItems = [leftBarItemCache]
    }
    
    func backNavigation(){
        webView.goBack()
    }

    func newAudioFileRequest(notification : NSNotification) {
        audioFileURL = notification.object as! NSURL
        
        _addTipView()
    }
    
    private func _addTipView () {
        
        var hasHadTipView : Bool = false
        
        for subview in view.subviews {
            if subview.tag == tipViewTag {
                hasHadTipView = true
            }
        }
        
        if hasHadTipView {return}
        
        let tipViewHeight : CGFloat = 50.0
        let tipView : UIView = UIView(frame: CGRectMake(0.0, view.frame.size.height - tipViewHeight - 49.0 , view.frame.size.width, tipViewHeight))
        tipView.tag = tipViewTag
        tipView.backgroundColor = UIColor.whiteColor()
        tipView.layer.shadowColor = UIColor(red:0.09, green:0.09, blue:0.09, alpha:0.2).CGColor
        tipView.layer.shadowOffset = CGSizeMake(0.0, -1.0)
        tipView.layer.shadowOpacity = 2.0
        tipView.layer.shadowRadius = 1.0
        
        let downloadButtonSize : CGSize = CGSizeMake(100.0, 40.0)
        let downloadButton : UIButton = UIButton(frame: CGRectMake(tipView.frame.size.width - 8.0 - downloadButtonSize.width, 5.0, downloadButtonSize.width, downloadButtonSize.height))
        downloadButton.setTitle("立即下载", forState: UIControlState.Normal)
        downloadButton.backgroundColor = UIColor(red:0.16, green:0.61, blue:0.99, alpha:1)
        downloadButton.layer.cornerRadius = 5.0
        downloadButton.addTarget(self, action: Selector("userTapDownloadButton:"), forControlEvents: UIControlEvents.TouchUpInside)
        tipView.addSubview(downloadButton)
        
        let tipTextLabelSize : CGSize = CGSizeMake(200.0, 40.0)
        let tipTextLabel : UILabel = UILabel(frame: CGRectMake(8.0, 5.0, tipTextLabelSize.width, tipTextLabelSize.height))
        tipTextLabel.text = "发现新的音频资源"
        tipView.addSubview(tipTextLabel)
        
        view.addSubview(tipView)
    }
    
    func userTapDownloadButton(sender : UIButton!) {
        NSNotificationCenter.defaultCenter().postNotificationName("NewDownloadTask", object: audioFileURL)
        
        for subview in view.subviews {
            if subview.tag == tipViewTag {
                subview.removeFromSuperview()
            }
        }
        
        uploadDownloadingCountToView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func _initAddressBar() {
        addressBar.layer.shadowColor = UIColor(red:0.09, green:0.09, blue:0.09, alpha:0.2).CGColor
        addressBar.layer.shadowOffset = CGSizeMake(0.0, 1.0)
        addressBar.layer.shadowOpacity = 2.0
        addressBar.layer.shadowRadius = 1.0
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        addressTextField.text = request.URL?.absoluteString
        
        if request.URL?.absoluteString != localNavigationURL.absoluteString {
            _addBackButton()
        } else {
            _removeBackButton()
        }
        
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        let webSiteTitle : String? = webView.stringByEvaluatingJavaScriptFromString("document.title")
        addressTextField.text = webSiteTitle
        
        let songTitle : String = webView.stringByEvaluatingJavaScriptFromString("$('.playerbody h3').text()")!
        
        print(songTitle)
        
        optimizeWebkitMemory()
    }
    
    
    func optimizeWebkitMemory () {
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "WebKitCacheModelPreferenceKey")
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "WebKitDiskImageCacheEnabled")
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "WebKitOfflineWebApplicationCacheEnabled")
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateBageForButton (count : Int) {
        let bageViewTag : Int = 1025
        var hasHadBageView : Bool = false
        /*
        for subview in downloadListButton.subviews {
            if count == 0 && subview.tag == bageViewTag {
                subview.removeFromSuperview()
                
                return
            }
            
            if subview.tag == bageViewTag {
                hasHadBageView = true
            }
        }
        */
        var bageView : UILabel = UILabel()
        /*
        if hasHadBageView == false {
            let bageViewSize : CGSize = CGSizeMake(16.0, 16.0)
            bageView = UILabel(frame: CGRectMake(downloadListButton.frame.size.width - bageViewSize.width / 2.0 , -bageViewSize.height / 2.0, bageViewSize.width, bageViewSize.height))
            bageView.backgroundColor = UIColor(red:0.11, green:0.56, blue:0.99, alpha:1)
            bageView.layer.cornerRadius = 8.0
            bageView.clipsToBounds = true
            bageView.textAlignment = NSTextAlignment.Center
            bageView.textColor = UIColor.whiteColor()
            bageView.font = UIFont(name:"HelveticaNeue-Bold", size: 10.0)
            bageView.tag = bageViewTag
            
            downloadListButton.addSubview(bageView)
        }
        */
        bageView.text = "\(count)"
        
    }
    
    func uploadDownloadingCountToView () {
        var downloadingCount : Int = taskList.count
        
        for task in taskList {
            if task.state != NSURLSessionTaskState.Running {
                downloadingCount--
            }
            /*
            switch task.state {
            case NSURLSessionTaskState.Running:
            downloadingCount++
            
            case NSURLSessionTaskState.Completed:
            print("\n")
            case NSURLSessionTaskState.Suspended:
            print("\n")
            default:
            break
            }
            */
        }
        
        updateBageForButton(downloadingCount)
    }
    
    //MARK: Download view protocol
    func updateProgress(index: Int, progress: Double) {
        uploadDownloadingCountToView()
    }
    
    func finishDownload(index: Int) {
        uploadDownloadingCountToView()
    }

}
