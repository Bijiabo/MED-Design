//
//  GrownScrollViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/19.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit

class GrownScrollViewController: UIViewController
{

    @IBOutlet var BottomScrollView: UIScrollView!
    @IBOutlet var topBackgroundView: UIView!

    var growUpCorona : GrowUpCorona!
    let pageCount : Int = 12
    let defaultPageIndex :Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clearColor()
        
        InitBottomScrollView()
        
        //初始化成长年轮
        let coronaView : UIView = UIView(frame: view.frame)
        coronaView.frame.size.height = view.frame.size.height - topBackgroundView.frame.size.height - BottomScrollView.frame.size.height
        coronaView.frame.origin.y = topBackgroundView.frame.size.height
        coronaView.clipsToBounds = true
        
        growUpCorona = GrowUpCorona(container: coronaView)
        growUpCorona.wallHeight = 200.0
        growUpCorona.renderView()
        
        view.addSubview(coronaView)
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
    
    
    //MARK: 初始化下方scrollView
    var recordViewController : GrownBottomLogViewController!
    var TipViewController : GrownBottomTextViewController!
    var StatisticsViewController : GrownBottomStatisticsViewController!
    
    func InitBottomScrollView ()
    {
        let height : CGFloat = BottomScrollView.frame.size.height
        
        BottomScrollView.contentSize = CGSizeMake( self.view.frame.size.width * 3.0, height)
        BottomScrollView.pagingEnabled = true
        BottomScrollView.showsHorizontalScrollIndicator = false
        BottomScrollView.showsVerticalScrollIndicator = false
        
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
    
}
