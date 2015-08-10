//
//  GrowUpCorona.swift
//  coronaForMED
//
//  Created by bijiabo on 15/8/10.
//  Copyright © 2015年 JYLabs. All rights reserved.
//
import UIKit
import Foundation

class GrowUpCorona : NSObject, UIScrollViewDelegate {
    
    var scrollView : UIScrollView = UIScrollView()
    var LandView : UIView!
    var Ruling : RulingView!
    let pageCount : Int = 14
    let containerView : UIView
    var landViewRadius : CGFloat
    let landViewRadiusScaleForContainerWidth : CGFloat = 2.5
    var wallHeight : CGFloat = 300.0 //场景中的墙高，既地面距离顶端的高度
    
    override init() {
        containerView = UIView(frame: CGRectMake(0, 0, 100.0, 100.0))
        landViewRadius = containerView.frame.size.width * landViewRadiusScaleForContainerWidth
        
        super.init()
    }
    
    init(container : UIView) {
        containerView = container
        landViewRadius = containerView.frame.size.width * landViewRadiusScaleForContainerWidth
        
        super.init()
    }
    
    func renderView() {
        //渲染视图
        _clearView()
        _initView()
    }
    
    private func _clearView() {
        for view in containerView.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func _initView() {
        _InitScrollView()
        _InitLandView()
        _InitRulingView()
        putSceneOnLand()
        //_PutThingsOnLand()
        //_RotateLand(5.0)
    }
    
    private func _InitScrollView()
    {
        scrollView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height)
        scrollView.pagingEnabled = true
        scrollView.scrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        
        scrollView.contentSize = CGSizeMake(containerView.frame.size.width * CGFloat(pageCount) , containerView.frame.size.height)
        
        containerView.addSubview(scrollView)
        /*
        for i in 0..<pageCount
        {
        let view : UIView = UIView(frame: CGRectMake( CGFloat(i) * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height))
        
        view.backgroundColor = i % 2 == 0 ? UIColor(red:0.36, green:0.55, blue:0.72, alpha:0.1) : UIColor(red:0, green:0, blue:0, alpha:0.1)
        
        scrollView.addSubview(view)
        }
        */
    }
    
    
    
    private func _InitLandView ()
    {
        let LandViewFrame : CGRect = CGRectMake(-landViewRadius+containerView.frame.size.width/2.0, wallHeight, landViewRadius*2.0, landViewRadius*2.0)
        
        LandView = UIView(frame: LandViewFrame)
        LandView.layer.cornerRadius = landViewRadius
        
        LandView.backgroundColor = UIColor(red:0.63, green:0.92, blue:0.49, alpha:1)
        
        containerView.addSubview(LandView)
        containerView.sendSubviewToBack(LandView)
    }
    
    private func _InitRulingView() {
        let RulingViewFrame : CGRect = CGRectMake(0.0, 0.0, landViewRadius*2.0, landViewRadius*2.0)
        
        Ruling = RulingView(frame: RulingViewFrame)
        Ruling.layer.cornerRadius = landViewRadius
        
        Ruling.backgroundColor = UIColor.clearColor() //UIColor(red:0.38, green:0.16, blue:0.5, alpha:0.3)
        
        LandView.addSubview(Ruling)
    }
    
    private func _PutThingsOnLand ()
    {
        for i in 0..<pageCount
        {
            let somethingSize : (width : CGFloat , height : CGFloat) = (width : 100.0 , height : 100.0)
            
            let something : UIView = UIView(frame: CGRectMake( GetX(angle: GetAngle(i) , radius: GetRaduis(LandView) ) , GetY(angle: GetAngle(i) , radius: GetRaduis(LandView) ) , somethingSize.width, somethingSize.height))
            
            something.backgroundColor = UIColor(red:0.64, green:0.43, blue:0.79, alpha:1)
            
            let textLabel : UILabel = UILabel(frame: CGRectMake(10, 10, 30, 30))
            textLabel.text = "\(i)"
            
            something.addSubview( textLabel )
            
            LandView.addSubview(something)
        }
        
    }
    
    private func _RotateLand (rotatePercent : CGFloat)
    {
        LandView.layer.transform = CATransform3DMakeRotation( 0 - (CGFloat(M_PI) * 2.0) * rotatePercent , 0.0, 0.0, 1.0)
        
    }
    
    func pageIndex() -> Int {
        return Int(scrollView.contentOffset.x / containerView.frame.size.width)
    }
    
    //MARK: scrollView delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let scrollPercent : CGFloat = scrollView.contentOffset.x / scrollView.contentSize.width
        
        _RotateLand(scrollPercent)
    }
    
    //MARK: useful functions
    func GetAngle(index : Int) -> CGFloat
    {
        let anglePerPage : CGFloat = 360.0 / CGFloat(pageCount)
        
        let angle : CGFloat = anglePerPage * CGFloat(index)
        
        return angle
        
        //asin( self.view.frame.size.width / 2 / GetRaduis(LandView) ) * 2.0 * CGFloat(index)
        
    }
    
    func GetRaduis(view : UIView) -> CGFloat
    {
        return view.frame.size.width/2
    }
    
    func GetX(angle angle : CGFloat , radius : CGFloat) -> CGFloat
    {
        var x : CGFloat = 0.0
        
        if angle < 90
        {
            x =  radius +  abs( sin(angle) * radius )
            
            let skewing = abs( sin(angle) * radius )
            
            print( skewing )
            
            print( radius / 2 * 1.732  )
            
            print(radius)
        }
        else if angle < 180
        {
            x = radius + abs( sin(180.0 - angle) * radius )
        }
        else if angle < 270
        {
            x = radius - sin(angle - 180.0) * radius
        }
        else
        {
            x = radius - sin(360.0 - angle) * radius
        }
        
        print( "angle : \(angle) , x = \(x)" )
        
        return x
    }
    
    func GetY(angle angle : CGFloat , radius : CGFloat) -> CGFloat
    {
        var y : CGFloat = 0.0
        
        if angle < 90
        {
            y = radius - abs( cos(angle) * radius )
        }
        else if angle < 180
        {
            y = radius + abs( cos(180.0 - angle) * radius )
        }
        else if angle < 270
        {
            y = radius + cos(angle - 180.0) * radius
        }
        else
        {
            y = radius - cos(360.0 - angle) * radius
        }
        
        print( "angle : \(angle) , y = \(y)" )
        
        return y
        
    }
    
    func putSceneOnLand() {
        //向land上添加场景
        let sceneHeight : CGFloat = LandView.frame.size.height
        let sceneWidth : CGFloat = LandView.frame.size.height / 2.0 * sin(CGFloat(M_PI)/CGFloat(pageCount))
        let sceneFrame : CGRect = CGRectMake((LandView.frame.size.width-sceneWidth)/2.0, 0.0, sceneWidth, sceneHeight)
        
        
        for i in 0..<pageCount
        {
            let leadContainer : UIView = UIView(frame: sceneFrame)
            //leadContainer.backgroundColor = UIColor(red:0.13, green:0.6, blue:0.68, alpha:0.5)
            /*
            //添加标记序号
            let textLabel : UILabel = UILabel(frame: CGRectMake(10, 10, 30, 30))
            textLabel.text = "\(i)"
            
            something.addSubview( textLabel )
            */
            
            //添加场景容器
            let sceneContainer : UIView = UIView(frame: containerView.frame)
            sceneContainer.frame.origin.x = sceneWidth/2.0 - containerView.frame.size.width/2.0
            sceneContainer.frame.origin.y = 0.0
            sceneContainer.frame.size.height = 100.0
            //sceneContainer.backgroundColor = UIColor(red:0.89, green:0.13, blue:0.07, alpha:0.3)
            leadContainer.addSubview(sceneContainer)
            
            //添加物品
            let sofa : UIImageView = UIImageView(frame: CGRectMake(containerView.frame.size.width/2.0-100.0, -70.0, 200.0, 80.0))
            sofa.image = UIImage(named: "sofaItem")
            sceneContainer.addSubview(sofa)
            
            //旋转
            leadContainer.layer.transform = CATransform3DMakeRotation( (CGFloat(M_PI) * 2.0) / CGFloat(pageCount)*CGFloat(i) , 0.0, 0.0, 1.0)
            
            LandView.addSubview(leadContainer)
            
        }
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if pageIndex() == pageCount-1 {
            scrollView.contentOffset.x = 0
        } else if pageIndex() == 0 {
            scrollView.contentOffset.x = containerView.frame.size.width
        }
    }
}