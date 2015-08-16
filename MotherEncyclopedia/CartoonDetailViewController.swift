//
//  CartoonDetailViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/8/16.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import UIKit

class CartoonDetailViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    var imageScrollVC : FullImageScrollViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageDirectoryPath : String = "cartoonImage"
        let imageDirectoryURL : NSURL = NSBundle.mainBundle().resourceURL!.URLByAppendingPathComponent( "\(imageDirectoryPath)/0" )
        var pages : Int = 0
        //获取文件目录
        let fileList: [AnyObject]?
        do {
            fileList = try NSFileManager.defaultManager().contentsOfDirectoryAtURL(imageDirectoryURL, includingPropertiesForKeys: nil, options: [])
            pages = fileList!.count / 3
        } catch let error as NSError {
            print(error)
        }
        
        var imageFilenames : Array<String> = Array<String>()
        for var i=0;i<pages;i++ {
            imageFilenames.append("\(i)")
        }
        
        imageScrollVC = FullImageScrollViewController(scrollView: scrollView, pageCount: pages, horizontallyDirection: true, imageDirectoryURL: imageDirectoryURL, imageFilenames: imageFilenames, pageControl: nil, subfix: "jpg")
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

}
