//
//  shopDetailContentViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/20.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit

class shopDetailContentViewController: UIViewController {

    @IBOutlet var GoodTitle: UILabel!
    @IBOutlet var ContentLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        InitContentLabel()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func InitContentLabel ()
    {
        let contentString : String = "妈妈在毛豆豆很小的时候就带着他玩颜色鲜艳的积木，现在毛豆豆对色彩和空间很熟悉，十几层的“大楼”一会儿就盖好了！这就是我们所说的针对宝宝感官敏感期进行刺激活动，从而帮助宝宝感官发展。感官为宝宝提供大量来自外界的信息。在这些信息的刺激下，宝宝的大脑发育开始完善。0-3岁是宝宝的感官敏感期，如果我们能在此时给予适当的感官刺激，那将对宝宝大脑的发育以及未来的探索世界有着非凡的意义。"
        
        var paragraphStyle : NSMutableParagraphStyle = NSMutableParagraphStyle()

        let lineHeight : CGFloat = 24.0
        
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        
        let font : UIFont = UIFont(name: "Arial", size: 16.0)!
        
        let attrs : NSDictionary = [
            NSParagraphStyleAttributeName : paragraphStyle,
            NSForegroundColorAttributeName : UIColor(red:1, green:1, blue:1, alpha:0.7),
            NSFontAttributeName : font
        ]
        ContentLabel.attributedText = NSAttributedString(string: contentString, attributes: attrs as! [String : AnyObject])
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
