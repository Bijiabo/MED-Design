//
//  FullImageScrollViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/8/16.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import Foundation
import UIKit

class FullImageScrollViewController: NSObject, UIScrollViewDelegate {
    
    let scrollView : UIScrollView
    let pageControl : UIPageControl?
    
    let pageCount : Int
    let horizontallyDirection : Bool
    let imageFilenames : Array<String>
    let subFix : String
    let imageDirectoryURL : NSURL
    
    enum deviceEnum{
        
        case iphone
        case iphoneRetina
        case iphone6plus
        case unknow
        
    }
    
    func getCurrentDevice() -> deviceEnum {
        
        //得到当前设备width或者height的最大值/2
        let greateerPixelDimension = UIScreen.mainScreen().bounds.size.width > UIScreen.mainScreen().bounds.size.height ? UIScreen.mainScreen().bounds.size.width : UIScreen.mainScreen().bounds.size.height * 2
        
        switch greateerPixelDimension {
        case 480:
            return deviceEnum.iphone
        case 960:
            return deviceEnum.iphoneRetina
        case 1136:
            return deviceEnum.iphoneRetina
        case 1334:
            return deviceEnum.iphoneRetina
        case 1472:
            return deviceEnum.iphone6plus
        case 1920:
            return deviceEnum.iphone6plus
        default:
            return deviceEnum.unknow
        }
        
    }
    
    internal func currentImageFlagAndSubFix() -> String {
        switch getCurrentDevice() {
        case deviceEnum.iphone:
            return ".\(subFix)"
        case deviceEnum.iphoneRetina:
            return "@2x.\(subFix)"
        case deviceEnum.iphone6plus:
            return "@3x.\(subFix)"
        default:
            return subFix
        }
    }
    
    override init() {
        pageCount = 0
        horizontallyDirection = true
        imageFilenames = Array<String>()
        imageDirectoryURL = NSBundle.mainBundle().resourceURL!
        subFix = ".png"
        
        scrollView = UIScrollView()
        pageControl = UIPageControl()
        pageControl?.numberOfPages = 0
        
        super.init()
    }
    
    init(scrollView : UIScrollView , pageCount : Int , horizontallyDirection : Bool , imageDirectoryURL : NSURL , imageFilenames : Array<String> , pageControl : UIPageControl? , subfix : String) {
        self.pageCount = pageCount
        self.horizontallyDirection = horizontallyDirection
        self.imageDirectoryURL = imageDirectoryURL
        self.imageFilenames = imageFilenames
        self.subFix = subfix
        
        self.scrollView = scrollView
        self.pageControl = pageControl
        self.pageControl?.numberOfPages = pageCount
        
        super.init()
        
        _initScrollView()
    }
    
    private func _initScrollView() {
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        scrollView.contentSize = horizontallyDirection ? CGSizeMake(scrollView.frame.size.width * CGFloat(pageCount) , scrollView.frame.size.height ) : CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height * CGFloat(pageCount))
        
        for var i=0;i<pageCount;i++ {
            //create the image container
            let imageViewFrame : CGRect = horizontallyDirection ? CGRectMake(scrollView.frame.size.width*CGFloat(i), 0.0, scrollView.frame.size.width, scrollView.frame.size.height) : CGRectMake(0.0, scrollView.frame.size.height*CGFloat(i), scrollView.frame.size.width, scrollView.frame.size.height)
            let imageView : UIImageView = UIImageView(frame: imageViewFrame)
            let imageFilePath : String = imageDirectoryURL.URLByAppendingPathComponent(imageFilenames[i] + currentImageFlagAndSubFix() ).relativePath!
            //imageView.image = UIImage(contentsOfFile: imageFilePath) //set image to the image container
            imageView.contentMode = UIViewContentMode.ScaleToFill
            
            //debug
            imageView.backgroundColor = i%2==0 ? UIColor.blackColor() : UIColor.whiteColor()
            print(scrollView.frame.size.width)
            print(UIScreen.mainScreen().bounds.width)
            
            //add the image container to scroll view
            scrollView.addSubview(imageView)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updatePageControl()
    }
    
    internal func updatePageControl() {
        pageControl?.currentPage = horizontallyDirection ? Int(scrollView.contentOffset.x / scrollView.frame.size.width) : Int(scrollView.contentOffset.y / scrollView.frame.size.height)
    }
}
