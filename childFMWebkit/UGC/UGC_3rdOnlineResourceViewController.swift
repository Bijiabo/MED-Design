//
//  UGC_3rdOnlineResourceViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/15.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit
import WebKit

class UGC_3rdOnlineResourceViewController: UIViewController,WKNavigationDelegate, UIScrollViewDelegate , Module , WKScriptMessageHandler
{
    var moduleLoader : ModuleLader?
    
    var webView : WKWebView!
    var userContentController : WKUserContentController!
    var configuration : WKWebViewConfiguration!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "在线资源"

        let handler = self
        userContentController = WKUserContentController()
        userContentController.addScriptMessageHandler(handler, name: "notification")
        
        configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        
        webView = WKWebView(frame: view.frame, configuration: configuration)
        
        webView.navigationDelegate = self
        
        //webView.scrollView.bounces = false
        webView.scrollView.delegate = self
        
        let url : NSURL! = NSURL(string:  "http://tnewp.cc/yy/UGC3rdOnlineResource.html")
        let req : NSURLRequest = NSURLRequest(URL: url)
        
        webView?.loadRequest(req)
        
        self.view = webView
        webView.navigationDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage)
    {
        if let action = message.body["action"] as? String
        {
            switch action
            {
                
            case "initMain":
                print("ugc 3rd online resource initMain func run...")
                
            default:
                break
            }
        }
        
    }
    
}
