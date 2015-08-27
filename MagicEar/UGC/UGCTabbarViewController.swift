//
//  UGCTabbarViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/8/27.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import UIKit

class UGCTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "添加内容"
        
        let closeButton : UIButton = UIButton(frame: CGRectMake(0.0, 0.0, 18.0, 18.0))
        closeButton.setBackgroundImage(UIImage(named: "close"), forState: UIControlState.Normal)
        closeButton.addTarget(self, action: Selector("backToDJ"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let customCloseBarButtonItem = UIBarButtonItem(customView: closeButton)
        navigationItem.leftBarButtonItem = customCloseBarButtonItem
        
        let downloadButton : UIButton = UIButton(frame: CGRectMake(0.0, 0.0, 18.0, 18.0))
        downloadButton.setBackgroundImage(UIImage(named: "download"), forState: UIControlState.Normal)
        downloadButton.addTarget(self, action: Selector("pushDownloadListVC"), forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: downloadButton)
        
    }
    
    func pushDownloadListVC(){
        let downloadListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("downloadList")
        
        navigationController?.pushViewController(downloadListVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backToDJ() {
        dismissViewControllerAnimated(true, completion: nil)
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
