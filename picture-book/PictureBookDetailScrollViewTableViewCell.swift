//
//  PictureBookDetailScrollViewTableViewCell.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/8/23.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import UIKit

class PictureBookDetailScrollViewTableViewCell: UITableViewCell {
    
    var width : CGFloat = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initScrollView() {
        let scrollView : UIScrollView = UIScrollView(frame: CGRectMake(0, 0, width, frame.size.height))
        
        addSubview(scrollView)
        
        scrollView.contentSize = CGSizeMake(frame.size.width*3.0, frame.size.height)
        scrollView.pagingEnabled = true
        
        for var i=0;i<3;i++ {
            let view : UIView = UIView(frame: CGRectMake(frame.size.width*CGFloat(i), 0, frame.size.width, frame.size.height))
            //view.backgroundColor = i%2==0 ? UIColor.grayColor() : UIColor.whiteColor()
            
            switch i {
            case 2:
                let chatImageView : UIImageView = UIImageView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
                chatImageView.image = UIImage(named: "chat")
                view.addSubview(chatImageView)
                
            case 1:
                let readImageView : UIImageView = UIImageView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
                readImageView.image = UIImage(named: "read")
                view.addSubview(readImageView)
                
            case 0:
                let readImageView : UIImageView = UIImageView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
                readImageView.image = UIImage(named: "jiangyi")
                view.addSubview(readImageView)
                
            default:
                break
            }
            
            scrollView.addSubview(view)
        }
        
    }

}
