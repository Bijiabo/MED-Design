//
//  DownloadView.swift
//  WebBrowserResourceDownloader
//
//  Created by bijiabo on 15/8/26.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import Foundation

protocol DownloadView {
    var URLList : Array<NSURL> {get set}
    var taskList : Array<NSURLSessionDownloadTask> {get set}
    
    func updateProgress(index : Int , progress : Double)
    func finishDownload(index : Int)
}

