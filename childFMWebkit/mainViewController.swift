//
//  ViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/4/3.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit
import WebKit

class mainViewController: UIViewController ,WKNavigationDelegate, UIScrollViewDelegate , Module , NavigationProtocol , GrownView
{
    var moduleLoader : ModuleLader?
    
    var operation : Operations?
    
    var webView : WKWebView!
    var userContentController : WKUserContentController!
    var configuration : WKWebViewConfiguration!
    var cache : Dictionary<String,AnyObject>!
    var scrollBeginY : CGFloat = 0.0
    var pageBeginIndexCache : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        
        cache = ["pageHeightArray":[]]
        
        let handler = webkitNotificationScriptMessageHandler(viewController: self)
        userContentController = WKUserContentController()
        userContentController.addScriptMessageHandler(handler, name: "notification")
        
        configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        
        webView = WKWebView(frame: view.frame, configuration: configuration)
        
        webView.navigationDelegate = self
        
        //webView.scrollView.bounces = false
        webView.scrollView.delegate = self
        webView.scrollView.pagingEnabled = true
        
        let baseURL: NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath)!
        var localUrl : NSURL! = baseURL.URLByAppendingPathComponent("web/main.html")//NSURL(string:"/web/main.html")
        //println(url)
        var localReq = NSURLRequest(URL:localUrl)
        
        let url : NSURL! = NSURL(string:  "http://127.0.0.1:8080/main.html")
        let req : NSURLRequest = NSURLRequest(URL: url)
        
        webView?.loadRequest(req)
        
        self.view = webView
        webView.navigationDelegate = self
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("webServerStarted:"), name: "webServerStarted", object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webServerStarted(notification : NSNotification) -> Void
    {
        println("webServerStarted func")
        
        let url : NSURL! = NSURL(string:  "http://127.0.0.1:8080/web/main.html")
        let req : NSURLRequest = NSURLRequest(URL: url)
        
        webView?.loadRequest(req)
    }
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        println("scrollView did scroll to top")
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        scrollBeginY = webView.scrollView.contentOffset.y
    }
    
    /*
    //MARK: 按照网页提供的pageHeightArray来搞定page垂直翻页
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        
        if let message: AnyObject = cache["pageHeightArray"]
        {
            if let pageHeightArray : AnyObject = message.body
            {
                if let pageYArray : NSArray = pageHeightArray["pageYArray"] as? NSArray
                {
                    
                    if targetContentOffset.memory.y > scrollBeginY && pageBeginIndexCache < pageYArray.count-1
                    {
                        targetContentOffset.memory.y = CGFloat(pageYArray.objectAtIndex(pageBeginIndexCache + 1) as! NSNumber)
                        pageBeginIndexCache += 1
                    }
                    else if targetContentOffset.memory.y < scrollBeginY && pageBeginIndexCache - 1 >= 0
                    {
                        let targetY : CGFloat = CGFloat(pageYArray.objectAtIndex(pageBeginIndexCache - 1) as! NSNumber)
                        let screenHeight = webView.frame.size.height
                        if abs(Int32(targetY-targetContentOffset.memory.y)) <= Int32(screenHeight)
                        {
                            targetContentOffset.memory.y = targetY
                            pageBeginIndexCache -= 1
                        }
                    }
                }
            }
   
        }
        
    }
    */
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //scrollView减速停止
        let offsetY : CGFloat = scrollView.contentOffset.y
        
        /*
        //若滚动到顶部，则为引导界面，禁止滚动。
        if offsetY == 0.0
        {
            scrollView.scrollEnabled = false
        }
        */
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        //通知页面已加载完成，执行js->swift数据等。
        webView.evaluateJavaScript("didFinishNavigation()", completionHandler: nil)
        
        //webView.scrollView.scrollEnabled = false
    }
    
    func setCache(#key:String, value:AnyObject)->Void{
        cache[key] = value
    }
    
    func scrollToPage(#forIndex : Int)
    {
        if let pageHeights : AnyObject = cache["pageHeightArray"]
        {
            if let pageHeightArray : AnyObject = pageHeights.body
            {
                if let pageYArray : NSArray = pageHeightArray["pageYArray"] as? NSArray
                {
                    if pageYArray.count > forIndex
                    {
                        let pageY : CGFloat = CGFloat(pageYArray.objectAtIndex(forIndex) as! NSNumber)
                        let offset : CGPoint = CGPointMake(0, pageY)
                        
                        self.webView.scrollView.setContentOffset( offset , animated: true)
                    }
                }
            }
        }
    }
    
    func loadModuleToNavigation (storyboardName : String , storyboardIdentifier : String)
    {
        let vc : UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(storyboardIdentifier) as! UIViewController

        if let Vc : DemoModule = vc as? DemoModule
        {
            var VC : DemoModule = vc as! DemoModule
            
            VC.navigationDelegate = self
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: 加载原生UI view
    func addNativeUI ()
    {
        //加载引导漫画scroll view
        var CartoonDetailViewController : cartoonDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("cartoonDetail") as! cartoonDetailViewController
        CartoonDetailViewController.imageDirectoryPath = "cartoonImage/5"
        CartoonDetailViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        
        self.addChildViewController( CartoonDetailViewController )
        self.webView.scrollView.addSubview( CartoonDetailViewController.view )
        
        //加载漫画列表头部标题
        var CartoonNavigationBar : UINavigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44.0))
//        CartoonNavigationBar.alpha = 0.5
//        var CartoonNavigationBarTitle : UIBarItem = UIBarItem()
//        CartoonNavigationBarTitle.title = "不要哑巴英语"
        
        //self.webView.scrollView.addSubview(CartoonNavigationBar)
        ///*
        var CartoonTitle : UILabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, 44.0))
        CartoonTitle.textAlignment = NSTextAlignment.Center
        CartoonTitle.text = "不要哑巴英语"
        
        //self.webView.scrollView.addSubview(CartoonTitle)
        //*/
        
        //加载漫画列表按钮
        let CartoonListButtonSize : (width : CGFloat , height : CGFloat) = (width : 70 , height : 70)
        
        var buttonForCartoonList : UIButton = UIButton(frame: CGRectMake(self.view.frame.size.width - 16.0 - CartoonListButtonSize.width , 30.0, CartoonListButtonSize.width, CartoonListButtonSize.height) )
        //buttonForCartoonList.setTitle("cartoonlist", forState: UIControlState.Normal)
        //buttonForCartoonList.backgroundColor = UIColor.blackColor()
        buttonForCartoonList.setImage(UIImage(named: "cartoonlist"), forState: UIControlState.Normal)
        buttonForCartoonList.addTarget(self, action: Selector("showCartoonList"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.webView.scrollView.addSubview(buttonForCartoonList)
        
        
        //加载成长年轮scroll view
        var grownScrollView : GrownScrollViewController = self.storyboard?.instantiateViewControllerWithIdentifier("grownScrollView") as! GrownScrollViewController
        
        grownScrollView.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)
        
        grownScrollView.InitScrollView()

        grownScrollView.grownView = self
        
        self.addChildViewController(grownScrollView)
        
        self.webView.scrollView.addSubview(grownScrollView.view)
        
        //加载playUI
        var playUIVC : UIViewController =  self.storyboard?.instantiateViewControllerWithIdentifier("playScrollViewController") as! UIViewController
        
        if let pageHeightArray : [Int] = getPageHeightArray()
        {
            println( pageHeightArray )
            
            playUIVC.view.frame = CGRectMake(0, CGFloat(pageHeightArray[2])  ,  self.view.frame.size.width , self.view.frame.size.height)
            
            if let playVC : DemoModule = playUIVC as? DemoModule
            {
                var playUIvc : DemoModule = playUIVC as! DemoModule
                
                playUIvc.navigationDelegate = self
            }
            
            if let playVC : PlayUI = playUIVC as? PlayUI
            {
                var playUIvc : PlayUI = playUIVC as! PlayUI
                
                //playUIvc.operation = self.operation
            }
            
            
            self.addChildViewController( playUIVC )
            
            self.webView.scrollView.addSubview( playUIVC.view )
        }
        
        //
        self.webView.scrollView.contentSize.height = self.view.frame.size.height * 3.0
    }
    
    func getPageHeightArray () -> [Int]?
    {
        if let pageHeights : AnyObject = cache["pageHeightArray"]
        {
            if let pageHeightArray : AnyObject = pageHeights.body
            {
                if let pageYArray : Array<Int> = pageHeightArray["pageYArray"] as? Array<Int>
                {
                    return pageYArray
                }
            }
        }

        return nil
    }
    
    //显示漫画列表
    func showCartoonList ()
    {
        loadModuleToNavigation("Main", storyboardIdentifier: "cartoonList")
    }
    
    func rotate(angle: Float)
    {
        webView.evaluateJavaScript("window.mainUserInfo.rotate(-\(angle))", completionHandler: nil)
    }
    
}


class webkitNotificationScriptMessageHandler: NSObject, WKScriptMessageHandler
{
    var vc : AnyObject!
    
    init(viewController : AnyObject) {
        vc = viewController
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage)
    {
        if let action = message.body["action"] as? String
        {
            switch action
            {
                
            case "initMain":
                //初始化主界面（wkwebview加载后激活）
                
                vc.setCache(key: "pageHeightArray", value: message)
                
                vc.addNativeUI()
                
            case "popNavigationItemAnimated":
                println("")
                
            case "endGuide":
                //结束引导模块，页面滑入年轮主界面
                vc.webView!.scrollView.scrollEnabled = true
                vc.scrollToPage(forIndex: 1)
                
            case "link2CartoonList":
                //加赞漫画模块
                vc.loadModuleToNavigation("Main", storyboardIdentifier: "cartoonList")
                
            case "loadNotificationList":
                //加载通知列表
                vc.loadModuleToNavigation("Main", storyboardIdentifier: "notificationList")
                
            default:
                break
            }
        }
        
    }
    
    
    
}

