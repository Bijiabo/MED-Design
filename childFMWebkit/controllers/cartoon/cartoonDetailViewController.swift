//
//  ViewController.swift
//  UIScrollViewDemo
//
//  Created by SlimAdam on 15/6/18.
//  Copyright (c) 2015年 SlimAdam. All rights reserved.
//

import UIKit


//枚举类型:标识不同ios设备
enum VJDeviceEnum{
    
    case VJDeviceEnum_iphone
    case VJDeviceEnum_iphoneRetina
    case VJDeviceEnum_ihphone6plus
    case VJDEviceEnum_unknow
    
    
}


class cartoonDetailViewController: UIViewController , UIScrollViewDelegate , Module
{
    var cartoonTitle : String = ""
    
    var moduleLoader : ModuleLader?
    
    var imageDirectoryPath : String = "cartoonImage"
    
    @IBOutlet var scrollVIew1: UIScrollView!
    
    @IBOutlet var pageControl: UIPageControl!
    //获取设备宽高
    var devWidth: CGFloat!
    var devHeight: CGFloat!
    
    //定义变量,页码数
    var pages : Int = 7
    
    var currentPix : CGFloat = 0
    
    var currentDeviceImageSubFix  = ""
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        devWidth = self.view.frame.size.width
        devHeight = self.view.frame.size.height
        
        currentDeviceImageSubFix = getCurrentDiveceImageFlag("jpg")
        //设置delegate属性，否则拓展拖动之后事件无法使用
        scrollVIew1.delegate = self
        
        // scrollVIew1.backgroundColor=UIColor.grayColor()
        //给页码数赋值
         self.setPageNum()
        
        //初始化scrollView
        self.initScrollView()
        
        //设置pageControl
        pageControl.numberOfPages = pages
        
        //设置navigationbar样式
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.translucent = true
        
        self.title = cartoonTitle
        
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
        println("\(bundleURL)")
        //在基础URL上新增URL路径
        let imageDirectoryURL : NSURL = bundleURL.URLByAppendingPathComponent( imageDirectoryPath )
        
        
        var error : NSError?
        //获取文件目录
        let fileList = NSFileManager.defaultManager().contentsOfDirectoryAtURL(imageDirectoryURL, includingPropertiesForKeys: nil, options: nil, error: &error)
        
        if error == nil{
            pages = fileList!.count / 3
        }
        else
        {
            println("setPageNum error!!!")
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

        return imageFlag
    }
    //初始化scrollView的方法
    func initScrollView(){
        
        //缩放系数
        let scaleRate: CGFloat = 1.0
        //设置宽高
        scrollVIew1.contentSize = CGSize(width: self.view.frame.size.width * CGFloat(pages), height: self.view.frame.size.height - 20.0)
        
        //初始化后的scrollView ->contentOffSet
        currentPix = scrollVIew1.contentOffset.x
        
        //println("scrollView(width,height)->\(scrollVIew1.contentSize)")
        
        for tempI in 0..<pages{
            
            let viewFrame : CGRect = CGRect(x: devWidth*CGFloat(tempI) + (devWidth - devWidth / scaleRate )/2, y: (devHeight - devHeight / scaleRate)/2, width: devWidth/scaleRate, height: devHeight/scaleRate)
            
            let containerView : UIView = UIView(frame: viewFrame)
            
            let imageView = UIImageView(frame: CGRectMake(0, 0, viewFrame.size.width, viewFrame.size.height))
            
            containerView.addSubview(imageView)
            
            //设置imageView的内容填充模式
            imageView.contentMode = UIViewContentMode.ScaleToFill
            
            //imageView.backgroundColor = UIColor.blackColor()
            
            //得到图片的URL
            var imageURL : NSURL = NSBundle.mainBundle().resourceURL!.URLByAppendingPathComponent("\(imageDirectoryPath)/\(tempI)" + currentDeviceImageSubFix)
            
            var isNotDir : ObjCBool = false
            
            if NSFileManager.defaultManager().fileExistsAtPath(imageURL.relativePath!, isDirectory: &isNotDir){
                
                imageView.image=UIImage(contentsOfFile: imageURL.relativePath!)
                
                // println("\(scrollVIew1.contentOffset)")
            }
            
            scrollVIew1.addSubview(containerView)
            
            //println("loop --> \(tempI)")
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
        
        println("当前设备大小:\(greateerPixelDimension)")
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
    
}

