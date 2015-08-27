//
//  MiiNSURLProtocol.swift
//  WebBrowserResourceDownloader
//
//  Created by bijiabo on 15/8/25.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import Foundation

class MiiNSURLProtocol: NSURLProtocol {
    
    override class func canInitWithRequest(request: NSURLRequest) -> Bool {
        
        let URLString : String? = request.URL?.absoluteString
        
        //print(URLString)
        
        if URLString?.rangeOfString(".mp3") != nil || URLString?.rangeOfString(".m4a") != nil {
            NSNotificationCenter.defaultCenter().postNotificationName("NewAudioFileRequest", object: request.URL, userInfo: nil)
        }
        
        return false
    }
    
    override class func canInitWithTask(request : NSURLSessionTask) -> Bool {
        
        print("Task-> " + request.currentRequest!.URL!.absoluteString)
        
        let URLString : String = request.currentRequest!.URL!.absoluteString
        
        if URLString.rangeOfString(".mp3") != nil || URLString.rangeOfString(".m4a") != nil {
            NSNotificationCenter.defaultCenter().postNotificationName("NewAudioFileRequest", object: request.currentRequest!.URL, userInfo: nil)
        }
        
        return false
    }
    
    override class func canonicalRequestForRequest(request: NSURLRequest) -> NSURLRequest
    {
        print(request)
        
        return request;
    }
    
    override class func requestIsCacheEquivalent(a: NSURLRequest, toRequest b: NSURLRequest) -> Bool
    {
        return false
    }
    
    override func startLoading() {
        print("start loading")
        super.startLoading()
    }
    
    override func stopLoading() {
        print("stop loading")
        super.stopLoading()
    }
}