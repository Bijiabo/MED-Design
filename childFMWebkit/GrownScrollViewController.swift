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
    @IBOutlet var explainTextLabel: UILabel!
    
    let pageCount : Int = 12
    let defaultPageIndex :Int = 10
    
    var grownView : GrownView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clearColor()
        
        //InitScrollView()
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
    
    //MARK: scrollView delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let scrollPercent : CGFloat = scrollView.contentOffset.x / scrollView.contentSize.width
        
        //let pageIndex : Int = Int(scrollView.contentOffset.x / self.view.frame.size.width)

        var angle : Float = 0.0
        
        angle =  Float( scrollView.contentOffset.x / self.view.frame.size.width * (360.0 / 12.0) )
        
        grownView?.rotate( angle )
        
    }

}
