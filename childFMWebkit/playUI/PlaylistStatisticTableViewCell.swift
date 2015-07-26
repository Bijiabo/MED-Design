//
//  PlaylistStatisticTableViewCell.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/25.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit

import PNChartSwift

class PlaylistStatisticTableViewCell: UITableViewCell , UIScrollViewDelegate
{

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    var ViewWidth : CGFloat = 375.0
    
    let ScrollViewPage : Int = 3
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print(self.frame.size)
        
        InitScrollView()
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func InitScrollView ()
    {
        pageControl.numberOfPages = ScrollViewPage
        pageControl.currentPage = 0
        
        scrollView.delegate = self
        scrollView.frame.size.width = ViewWidth
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        for i in 0..<ScrollViewPage
        {
            let View : UIView = UIView(frame: CGRectMake(ViewWidth * CGFloat(i), 0, scrollView.frame.size.width, scrollView.frame.size.height))
            
            /*
            if i % 2 == 0
            {
                View.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1)
            }
            else
            {
                View.backgroundColor = UIColor(red:0.37, green:0.75, blue:0.38, alpha:1)
            }
            */
            
            switch i
            {
            case 0:
                AddBarChartToView( View )
            case 1:
                AddLineChartToView( View )
            default:
                break
            }
            
            
            scrollView.contentSize = CGSizeMake(ViewWidth * CGFloat(ScrollViewPage), self.frame.size.height)
            
            scrollView.addSubview( View )
        }
    }
    
    func AddBarChartToView(view : UIView)
    {
        let chartFrame : CGRect = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 20.0)
        
        let barChart : PNBarChart = PNBarChart(frame: chartFrame )
        barChart.backgroundColor = UIColor.clearColor()
        
        // remove for default animation (all bars animate at once)
        barChart.animationType = .Waterfall
        
        
        barChart.labelMarginTop = 5.0
        barChart.xLabels = ["SEP 1","SEP 2","SEP 3","SEP 4","SEP 5","SEP 6","SEP 7"]
        barChart.yValues = [1,24,12,18,30,10,21]
        barChart.strokeChart()
        
        view.addSubview( barChart )
    }
    
    func AddLineChartToView(view : UIView)
    {
        let chartFrame : CGRect = CGRectMake(10.0, 10.0, view.frame.size.width - 20.0, view.frame.size.height - 40.0)
        
        let lineChart : PNLineChart = PNLineChart(frame: chartFrame)
        lineChart.yLabelFormat = "%1.1f"
        lineChart.showCoordinateAxis = true
        lineChart.showLabel = true
        lineChart.xLabels = ["SEP 1","SEP 2","SEP 3","SEP 4","SEP 5","SEP 6","SEP 7"]
        lineChart.backgroundColor = UIColor.clearColor()

        
        //line chart no.0
        let dataArray : [CGFloat] = [1.0, 24.0, 12.0, 18.0, 30.0, 10.0, 21.0]
        let data0 : PNLineChartData = PNLineChartData()
        data0.color = PNGreenColor
        data0.itemCount = lineChart.xLabels.count
        data0.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
        data0.getData = ({(index: Int) -> PNLineChartDataItem in
            
            var yValue : CGFloat = dataArray[index]
            var item = PNLineChartDataItem(y: yValue)
            
            return item
        })
        
        lineChart.chartData = [data0]
        lineChart.strokeChart()
        
        view.addSubview( lineChart )
        
    }
    
    func AddPineChartToView(view : UIView)
    {
        let chartFrame : CGRect = CGRectMake(10.0, 10.0, view.frame.size.width - 20.0, view.frame.size.height - 40.0)
        
    }

}
