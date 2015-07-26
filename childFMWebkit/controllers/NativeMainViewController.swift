//
//  NativeMainViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/26.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import UIKit

class NativeMainViewController: UIViewController , NavigationProtocol , GrownView {

    @IBOutlet var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        
        initScrollView()
        
        addNativeUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func initScrollView() {
        let scrollViewPageCount : Int = 3
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.pagingEnabled = true
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * CGFloat(scrollViewPageCount))
        
        for pageIndex in 0..<scrollViewPageCount
        {
            let view : UIView = UIView(frame: CGRectMake(0, self.view.frame.size.height * CGFloat(pageIndex), self.view.frame.size.width, self.view.frame.size.height))
            
            switch pageIndex
            {
            case 0:
                view.backgroundColor = UIColor(red:0.56, green:0.9, blue:0.41, alpha:1)
            case 1:
                view.backgroundColor = UIColor(red:0.26, green:0.83, blue:0.85, alpha:1)
            case 2:
                view.backgroundColor = UIColor(red:0.93, green:0.39, blue:0.34, alpha:1)
            default:
                break
            }
            
            scrollView.addSubview(view)
        }
        
    }

    //MARK: 加载原生UI view
    func addNativeUI ()
    {
        //加载引导漫画scroll view
        let CartoonDetailViewController : cartoonDetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("cartoonDetail") as! cartoonDetailViewController
        CartoonDetailViewController.imageDirectoryPath = "cartoonImage/5"
        CartoonDetailViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        
        self.addChildViewController( CartoonDetailViewController )
        self.scrollView.addSubview( CartoonDetailViewController.view )
        
        //加载漫画列表头部标题
        var CartoonNavigationBar : UINavigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44.0))
        //        CartoonNavigationBar.alpha = 0.5
        //        var CartoonNavigationBarTitle : UIBarItem = UIBarItem()
        //        CartoonNavigationBarTitle.title = "不要哑巴英语"
        
        //self.webView.scrollView.addSubview(CartoonNavigationBar)
        ///*
        let CartoonTitle : UILabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, 44.0))
        CartoonTitle.textAlignment = NSTextAlignment.Center
        CartoonTitle.text = "不要哑巴英语"
        
        //self.webView.scrollView.addSubview(CartoonTitle)
        //*/
        
        //加载漫画列表按钮
        let CartoonListButtonSize : (width : CGFloat , height : CGFloat) = (width : 70 , height : 70)
        
        let buttonForCartoonList : UIButton = UIButton(frame: CGRectMake(self.view.frame.size.width - 16.0 - CartoonListButtonSize.width , 30.0, CartoonListButtonSize.width, CartoonListButtonSize.height) )
        //buttonForCartoonList.setTitle("cartoonlist", forState: UIControlState.Normal)
        //buttonForCartoonList.backgroundColor = UIColor.blackColor()
        buttonForCartoonList.setImage(UIImage(named: "cartoonlist"), forState: UIControlState.Normal)
        buttonForCartoonList.addTarget(self, action: Selector("showCartoonList"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.scrollView.addSubview(buttonForCartoonList)
        
        
        //加载成长年轮scroll view
        let grownScrollView : GrownScrollViewController = self.storyboard?.instantiateViewControllerWithIdentifier("grownScrollView") as! GrownScrollViewController
        
        grownScrollView.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)
        
        grownScrollView.InitScrollView()
        
        grownScrollView.grownView = self
        
        self.addChildViewController(grownScrollView)
        
        self.scrollView.addSubview(grownScrollView.view)
        
        //加载playUI
        let playUIVC : UIViewController =  self.storyboard!.instantiateViewControllerWithIdentifier("playScrollViewController") as UIViewController
        
        if true//let pageHeightArray : [Int] = getPageHeightArray()
        {
            
            playUIVC.view.frame = CGRectMake(0, self.view.frame.size.height * 2.0  ,  self.view.frame.size.width , self.view.frame.size.height)
            
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
            
            self.scrollView.addSubview( playUIVC.view )
        }
        
        //
        self.scrollView.contentSize.height = self.view.frame.size.height * 3.0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: Navigation Protocol
    func loadModuleToNavigation (storyboardName : String , storyboardIdentifier : String)
    {
        let vc : UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(storyboardIdentifier) as UIViewController
        
        if let Vc : DemoModule = vc as? DemoModule
        {
            var VC : DemoModule = vc as! DemoModule
            
            VC.navigationDelegate = self
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: GrownView
    func rotate(angle: Float)
    {
        //webView.evaluateJavaScript("window.mainUserInfo.rotate(-\(angle))", completionHandler: nil)
    }
}
