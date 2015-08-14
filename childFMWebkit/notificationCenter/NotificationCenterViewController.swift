//
//  NotificationCenterViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/22.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit

class NotificationCenterViewController: UIViewController {

    @IBOutlet var classView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    
    var HighlightViewForClass : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func InitClassView ()
    {
        let ViewWidth : CGFloat = self.view.frame.size.width
        
        let Label0 : UILabel = UILabel(frame: CGRectMake(0, 40.0, ViewWidth / 4.0, 40.0))
        Label0.textAlignment = NSTextAlignment.Center
        
        Label0.text = "全部消息"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
