//
//  cartoonListTableViewCell.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/12.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit

class cartoonListTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    var tip : Bool = false {
        didSet {
            
            let tipLayer : CALayer = CALayer()
            
            tipLayer.frame = CGRectMake( 10, 17, 10, 10 )
            
            if tip == true
            {
                tipLayer.backgroundColor = UIColor(red:0, green:0.69, blue:0.96, alpha:1).CGColor
            }
            else
            {
                tipLayer.backgroundColor = UIColor.whiteColor().CGColor
            }
            
            tipLayer.cornerRadius = 5.0
            
            self.layer.addSublayer(tipLayer)
            
        }
    }

}
