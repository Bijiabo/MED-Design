//
//  RulingView.swift
//  coronaForMED
//
//  Created by bijiabo on 15/8/9.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import UIKit

class RulingView: UIView {
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let context:CGContextRef =  UIGraphicsGetCurrentContext();//获取画笔上下文
        CGContextSetAllowsAntialiasing(context, true) //抗锯齿设置
        
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor) //设置画笔颜色
        
        let lineWidth : CGFloat = 20.0
        let radius : CGFloat = frame.size.width/2.0
        
        CGContextSetLineWidth(context, lineWidth)
        CGContextSetLineDash(context, 0, [2,30], 2)
        CGContextAddArc(context, radius, radius, radius, 0, CGFloat(M_PI/180)*360.0 , 1)
        CGContextStrokePath(context)
    }
    
    
}
