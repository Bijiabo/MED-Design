//
//  GrownScrollViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/19.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit

class GrownScrollViewController: UIViewController , UIScrollViewDelegate
{

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var BottomScrollView: UIScrollView!
    
    let pageCount : Int = 12
    let defaultPageIndex :Int = 10
    
    var grownView : GrownView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clearColor()
        
        //InitScrollView()
        InitBottomScrollView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func InitScrollView()
    {
        scrollView.pagingEnabled = true
        scrollView.scrollEnabled = true
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.alpha = 0.5
        
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width * CGFloat(pageCount) , self.view.frame.size.height)

        //MARK: debug switch
        let debug : Bool = false
        
        if debug == true
        {
            for i in 0...pageCount
            {
                let view : UIView = UIView(frame: CGRectMake( CGFloat(i) * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height))
                
                view.backgroundColor = i % 2 == 0 ? UIColor(red:0.36, green:0.55, blue:0.72, alpha:0.5) : UIColor(red:0, green:0, blue:0, alpha:0.3)
                
                scrollView.addSubview(view)
            }
        }
        
        scrollView.setContentOffset(CGPointMake(self.view.frame.size.width * CGFloat(defaultPageIndex), 0), animated: true)
    }
    
    //MARK: 初始化下方scrollView
    var recordViewController : GrownBottomLogViewController!
    var TipViewController : GrownBottomTextViewController!
    var StatisticsViewController : GrownBottomStatisticsViewController!
    
    func InitBottomScrollView ()
    {
        println("self.view.frame.size.width = \(self.view.frame.size.width)")
        println("BottomScrollView.frame.size.height = \(BottomScrollView.frame.size.height)")

        let height : CGFloat = BottomScrollView.frame.size.height
        
        BottomScrollView.contentSize = CGSizeMake( self.view.frame.size.width * 3.0, height)
        BottomScrollView.pagingEnabled = true
        
        BottomScrollView.backgroundColor = UIColor(red:0.65, green:0.93, blue:0.52, alpha:0.4)
        
        for i in 0..<3
        {
            let vc : UIView = UIView(frame: CGRectMake(self.view.frame.size.width * CGFloat(i), 0, self.view.frame.size.width, height))
            if i % 2 == 0
            {
                vc.backgroundColor = UIColor(red:0.29, green:0.71, blue:0.97, alpha:0.5)
            }
            else
            {
                vc.backgroundColor = UIColor(red:0.91, green:0.32, blue:0.28, alpha:0.5)
            }
            
            switch i
            {
            case 0:
                //加载按钮组
                recordViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GrownBottomRecordVC") as! GrownBottomLogViewController
                recordViewController.view.frame = CGRectMake(0, 0, vc.frame.size.width, vc.frame.size.height)
                self.addChildViewController( recordViewController )
                vc.addSubview( recordViewController.view )
                
            case 1:
                //加载文字提示
                TipViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GrownBottomTextVC") as! GrownBottomTextViewController
                TipViewController.view.frame = CGRectMake(0, 0, vc.frame.size.width, vc.frame.size.height)
                self.addChildViewController( TipViewController )
                vc.addSubview( TipViewController.view )
                
            case 2:
                //加载统计数据
                StatisticsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("GrownBottomStatisticsVC") as! GrownBottomStatisticsViewController
                StatisticsViewController.view.frame = CGRectMake(0, 0, vc.frame.size.width, vc.frame.size.height)
                self.addChildViewController( StatisticsViewController )
                vc.addSubview( StatisticsViewController.view )

                
            default:
                break
            }
            
            
            BottomScrollView.addSubview(vc)
        }
        
        BottomScrollView.setContentOffset( CGPointMake(self.view.frame.size.width, 0.0) , animated: false)
    }
    
    //MARK: scrollView delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let scrollPercent : CGFloat = scrollView.contentOffset.x / scrollView.contentSize.width
        
        //let pageIndex : Int = Int(scrollView.contentOffset.x / self.view.frame.size.width)

        var angle : Float = 0.0
        
        angle =  Float( scrollView.contentOffset.x / self.view.frame.size.width * (360.0 / 12.0) )
        
        grownView?.rotate( angle )
        
    }

}
