//
//  UGCHomeViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/14.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit

class UGCHomeViewController: UIViewController , DemoModule
{
    var navigationDelegate : NavigationProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "添加内容"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func tapToTurtoalForiTunes(sender: AnyObject) {
        //用户点击「通过iTunes上传」按钮
        
    }
    
    @IBAction func tap3rdOnlineResource(sender: AnyObject) {
        //用户点击「浏览在线资源」按钮
        
    }
}
