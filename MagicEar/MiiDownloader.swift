//
//  MiiDownloader.swift
//  WebBrowserResourceDownloader
//
//  Created by bijiabo on 15/8/26.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import Foundation

class MiiDownloader: NSObject , NSURLSessionDelegate , NSURLSessionDownloadDelegate {
    
    var downloadURLs : Array<NSURL> = Array<NSURL>()
    var downloadTasks : Array<NSURLSessionDownloadTask> = Array<NSURLSessionDownloadTask>()
    var downloadViews : Array<DownloadView> = Array<DownloadView>()
    
    override init() {
        super.init()
        
        _addObservers()
    }
    
    
    private func _addObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("newDownloadTask:"), name: "NewDownloadTask", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("sendDownloadListData:"), name: "NeedDownloadListData", object: nil)
    }
    
    
    func newDownloadTask(notification : NSNotification) {
        let audioFileURL : NSURL = notification.object as! NSURL
        
        createTaskAtURL(audioFileURL)
    }
    
    
    func sendDownloadListData(notification : NSNotification) {
        let downloadView : DownloadView = notification.object as! DownloadView
        downloadViews.append(downloadView)
        
        updateDownloadViewsData()
    }
    
    func updateDownloadViewsData() {
        for var i=0;i<downloadViews.count;i++ {
            downloadViews[i].URLList = downloadURLs
            downloadViews[i].taskList = downloadTasks
        }
    }
    
    func createTaskAtURL (url : NSURL) {
        
        //check if had created
        for urlItem in downloadURLs {
            if urlItem.absoluteString == url.absoluteString {return}
        }
        
        //let sessionConfigure : NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session : NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
        let task : NSURLSessionDownloadTask = session.downloadTaskWithURL(url)
        task.resume()
        
        downloadTasks.append(task)
        downloadURLs.append(url)
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if downloadTask.state == NSURLSessionTaskState.Running && totalBytesWritten > 0 && totalBytesExpectedToWrite > 0{
            
            let index : Int? = downloadTasks.indexOf(downloadTask)
            if index == nil {return}
            
            let percentage : Double = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite) * 100.0
            
            for downloadViewItem in downloadViews {
                downloadViewItem.updateProgress(index!, progress: percentage)
            }
        }
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        
        if let index : Int = downloadTasks.indexOf(downloadTask) {
            for var i=0;i<downloadViews.count;i++ {
                downloadViews[i].URLList = downloadURLs
                downloadViews[i].taskList = downloadTasks
                downloadViews[i].finishDownload(index)
            }
        }
        
        let cachePath : String = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]
        
        var targetURL : NSURL = NSURL(fileURLWithPath: cachePath)
        targetURL = targetURL.URLByAppendingPathComponent(downloadTask.currentRequest!.URL!.lastPathComponent!)
        
        if !NSFileManager.defaultManager().fileExistsAtPath(targetURL.relativePath!) {
            do {
                try NSFileManager.defaultManager().copyItemAtURL(location, toURL: targetURL)
            }catch let error as NSError {
                print("-----------\n\n")
                print(error)
            }
        }
        
    }
}