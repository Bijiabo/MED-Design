//
//  playScrollViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/18.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//
//
//  UGC_iTunesGuide.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/15.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import Foundation
import UIKit

class playScrollViewController: UIViewController , UIScrollViewDelegate , Module
{
    //枚举类型:标识不同ios设备
    enum VJDeviceEnum{
        case VJDeviceEnum_iphone
        case VJDeviceEnum_iphoneRetina
        case VJDeviceEnum_ihphone6plus
        case VJDEviceEnum_unknow 
    }
    
    var data : [Dictionary<String, String>] = [
        [
            "AudioName" : "My Shunshine",
            "AudioTag" : "Children's Song",
            "Scene" : "玩耍磨耳朵",
            "GiftTipCount" : "3"
        ],
        [
            "AudioName" : "Babs Seed",
            "AudioTag" : "Cartoon Song",
            "Scene" : "午后磨耳朵",
            "GiftTipCount" : "2"
        ],
        [
            "AudioName" : "Always With Me",
            "AudioTag" : "Music",
            "Scene" : "睡前磨耳朵",
            "GiftTipCount" : "5"
        ],
        [
            "AudioName" : "Baby Toys",
            "AudioTag" : "Music",
            "Scene" : "起床磨耳朵",
            "GiftTipCount" : "7"
        ]
        
    ]
    
    var moduleLoader : ModuleLader?
    
    let imageDirectoryName : String = "iTunesGuide"
    
    @IBOutlet var scrollVIew1: UIScrollView!
    
    @IBOutlet var pageControl: UIPageControl!
    //获取设备宽高
    let devWidth: CGFloat = UIScreen.mainScreen().bounds.width
    let devHeight: CGFloat = UIScreen.mainScreen().bounds.height
    
    //定义变量,页码数
    var pages : Int = 4
    
    var currentPix : CGFloat = 0
    
    var currentDeviceImageSubFix : String = ""
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDeviceImageSubFix = getCurrentDiveceImageFlag("jpg")
        //设置delegate属性，否则拓展拖动之后事件无法使用
        scrollVIew1.delegate = self
        
        // scrollVIew1.backgroundColor=UIColor.grayColor()
        //给页码数赋值
        //self.setPageNum()
        
        //初始化scrollView
        self.initScrollView()
        
        //设置pageControl
        pageControl.numberOfPages = pages
        
        //设置navigationbar样式
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.translucent = true
        
        self.title = "主界面"
        
        addPlayStatusObserver()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //获取指定目录下的图片数量
    func setPageNum () {
        
        //返回当前项目根目录NSURL对象
        let bundleURL : NSURL = NSBundle.mainBundle().resourceURL!
        print("\(bundleURL)")
        //在基础URL上新增URL路径
        let imageDirectoryURL : NSURL = bundleURL.URLByAppendingPathComponent( imageDirectoryName )
        
        
        var error : NSError?
        //获取文件目录
        let fileList: [AnyObject]?
        do {
            fileList = try NSFileManager.defaultManager().contentsOfDirectoryAtURL(imageDirectoryURL, includingPropertiesForKeys: nil, options: [])
        } catch var error1 as NSError {
            error = error1
            fileList = nil
        }
        
        if error == nil{
            
            pages = fileList!.count / 3
            
        }else{
            print("setPageNum error!!!")
        }
        
        
    }
    //给定一个图片的格式,返回匹配设备大小
    func getCurrentDiveceImageFlag(subFix : String ) ->String{
        var imageFlag = ""
        
        
        switch getCurrentDevice() {
            
        case .VJDeviceEnum_iphone:
            imageFlag = "." + subFix
        case .VJDeviceEnum_iphoneRetina:
            imageFlag += "@2x" + "." + subFix
        case .VJDeviceEnum_ihphone6plus:
            imageFlag += "@3x" + "." + subFix
        default:
            imageFlag += subFix
        }
        
        //println("imageFlag:-->\(imageFlag)")
        return imageFlag
    }
    
    //初始化scrollView的方法
    func initScrollView(){
        
        self.scrollVIew1.backgroundColor = UIColor(red:0.42, green:0.46, blue:0.52, alpha:1)
        
        //设置宽高
        scrollVIew1.contentSize = CGSize(width: devWidth*CGFloat(pages), height: devHeight)
        
        //初始化后的scrollView ->contentOffSet
        currentPix = scrollVIew1.contentOffset.x
        
        //println("scrollView(width,height)->\(scrollVIew1.contentSize)")
        
        for tempI in 0..<pages{
            
            let playUIVC : UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("playUI") as UIViewController
            
            playUIVC.view.frame = CGRectMake(self.view.frame.size.width * CGFloat(tempI) , 0, self.view.frame.size.width, self.view.frame.size.height)
            
            if let _ : playViewController =  playUIVC as? playViewController
            {
                let playUIVC : playViewController = playUIVC as! playViewController
                
                playUIVC.playPauseSwitchButton.setBackgroundImage(UIImage(named: "switchButton_left"), forState: UIControlState.Normal)
                
                playUIVC.view.tag = tempI //标记Play view controll 序号
                playUIVC.playPauseSwitchButton.tag = 2 //0 = playButton , 1 = pauseButton , 2 = switch
                
                switch tempI
                {
                case 0:
                    playUIVC.VideoFileName = "airplane.mp4"
                    playUIVC.playPauseSwitchButton.setBackgroundImage(UIImage(named: "pauseButton"), forState: UIControlState.Normal)
                    playUIVC.playPauseSwitchButton.tag = 1
                    
                case 1:
                    playUIVC.VideoFileName = "pirate.mp4"
                case 2:
                    playUIVC.VideoFileName = "town.mp4"
                case 3:
                    playUIVC.VideoFileName = "fisherPrice.mp4"
                default:
                    break
                }
                
                playUIVC.AudioName.text = data[tempI]["AudioName"]
                playUIVC.AudioTag.text = data[tempI]["AudioTag"]
                playUIVC.FakeNavigationBarTitle.title = data[tempI]["Scene"]
                playUIVC.GiftTipCount.text = data[tempI]["GiftTipCount"]
                
            }
            
            self.addChildViewController( playUIVC )
            playUIVC.view.clipsToBounds = true
            
            scrollVIew1.addSubview( playUIVC.view )
        }
    }
    
    //
    
    func clickCancelButton(){
        
        /*
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC : UIViewController = storyboard.instantiateViewControllerWithIdentifier("mainVC") as! UIViewController
        
        self.presentViewController(mainVC, animated: true, completion: nil)
        */
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "applicationHadActivated")
        
        moduleLoader?.loadModule("Main", storyboardIdentifier: "mainVC")
    }
    
    func clickConfirmButton(){
        
        moduleLoader?.loadModule("Guide", storyboardIdentifier: "datePickerVC")
        
    }
    
    
    //正在拖动的时候调用
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // println("\(scrollView.contentOffset.x)")
        dynAddImage(scrollView,pageC: pageControl)
        pageControl.currentPage = Int(scrollView.contentOffset.x / devWidth)
    }
    
    //拖动结束调用
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        //println("currentPage:-->\(scrollView.contentOffset.x / devWidth)")
        
        //设置拖动页面之后当前的pageControl
        
    }
    
    
    //内存优化,动态添加图片
    func dynAddImage(sv : UIScrollView , pageC: UIPageControl){
        //判断用户是左滑还是右滑
        
        let tempPix : Int = Int(sv.contentOffset.x) - Int(currentPix)
        
        if(tempPix > 0){
            
            //  println("drag right")
            
        }else{
            
            // println("drag left")
        }
        
        currentPix = sv.contentOffset.x
    }
    
    //return:VJDeviceEnum,判断当前设备,返回一个枚举类型的设备标识
    func getCurrentDevice() ->VJDeviceEnum{
        
        //得到当前设备width或者height的最大值/2
        let greateerPixelDimension = UIScreen.mainScreen().bounds.size.width > UIScreen.mainScreen().bounds.size.height ? UIScreen.mainScreen().bounds.size.width :UIScreen.mainScreen().bounds.size.height * 2
        
        print("当前设备大小:\(greateerPixelDimension)")
        switch greateerPixelDimension {
            
        case 480:
            return VJDeviceEnum.VJDeviceEnum_iphone
        case 960:
            return VJDeviceEnum.VJDeviceEnum_iphoneRetina
        case 1136:
            return VJDeviceEnum.VJDeviceEnum_iphoneRetina
        case 1334:
            return VJDeviceEnum.VJDeviceEnum_iphoneRetina
        case 1472:
            return VJDeviceEnum.VJDeviceEnum_ihphone6plus
        case 1920:
            return VJDeviceEnum.VJDeviceEnum_ihphone6plus
        default:
            return VJDeviceEnum.VJDEviceEnum_unknow
            
        }
        
        
    }
    
    //播放状态切换
    func addPlayStatusObserver ()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("PlayUIVC_Play:"), name: "PlayUIVC_Play", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("PlayUIVC_Pause:"), name: "PlayUIVC_Pause", object: nil)
    }
    
    func PlayUIVC_Play (notification : NSNotification)
    {
        let ActiveIndex : Int = notification.object as! Int
        
        changeViewForStatus(ActiveIndex, status: "play")
    }
    
    func PlayUIVC_Pause (notification : NSNotification)
    {
        let ActiveIndex : Int = notification.object as! Int
        
        changeViewForStatus(ActiveIndex, status: "pause")
    }
    
    //改变状态
    func changeViewForStatus ( ActiveIndex : Int , status : String )
    {
        //改变按钮状态
        for childViewController in self.childViewControllers
        {
            if let childVC : playViewController = childViewController as? playViewController
            {
                if childVC.view.tag == ActiveIndex
                {
                    let ButtonImageName : String = status == "play" ? "pauseButton" : "playButton"

                    childVC.playPauseSwitchButton.setBackgroundImage(UIImage(named: ButtonImageName), forState: UIControlState.Normal)
                    
                    childVC.playPauseSwitchButton.tag = status == "play" ? 1 : 0
                }
                else
                {
                    let ButtonImageName : String = childVC.view.tag < ActiveIndex ? "switchButton_right" : "switchButton_left"
                    
                    childVC.playPauseSwitchButton.setBackgroundImage(UIImage(named: ButtonImageName), forState: UIControlState.Normal)
                    
                    childVC.playPauseSwitchButton.tag = 2
                }
            }
        }
        
        //滚动scrollView
        self.scrollVIew1.scrollRectToVisible(CGRectMake(self.view.frame.size.width * CGFloat(ActiveIndex), 0, self.view.frame.size.width, self.view.frame.size.height), animated: true)
    }
    
    
    
}