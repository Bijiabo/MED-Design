//
//  MiiServer.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/8/28.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import Foundation

class MiiServer: NSObject {
    
    var data : JSON = JSON(Dictionary<String,String>())
    var playOrderIndex : Dictionary<String , Int> = Dictionary<String , Int>()
    
    override init() {
        super.init()
        
        _initData()
    }
    
    //MARK: internal func
    func patternList () {
        
    }
    
    func playDataForPattern (pattern : String) -> JSON {
        
        for (_,subJson):(String, JSON) in data {
            
            if subJson["name"].stringValue == pattern {
                return subJson["list"][_getPlayOrderIndexForPattern(pattern)]
            }
        }
        
        return JSON(Dictionary<String,String>())
    }
    
    
    
    //MARK: private func
    private func _initData () {
        let dataFilename : String = "\(_loadDefaultAge()).json"
        
        data = _loadDataFromeURL( _loadDataFile( dataFilename ) )
    }
    
    private func _loadDefaultAge() -> Int {
        return NSUserDefaults.standardUserDefaults().integerForKey("childAge")
    }
    
    private func _loadDataFile(filename : String = "0.json") -> NSURL {
        let fileURL : NSURL = NSBundle.mainBundle().resourceURL!.URLByAppendingPathComponent("data/\(filename)")

        return fileURL
    }
    
    private func _loadDataFromeURL(url : NSURL) -> JSON {
        var isNotDir : ObjCBool = false
        if NSFileManager.defaultManager().fileExistsAtPath(url.relativePath!, isDirectory: &isNotDir) {
            let data : NSData = NSData(contentsOfURL: url)!
            
            return JSON(data: data)
        }else {
            return JSON(Dictionary<String,String>())
        }
    }
    
    private func _setDefaultPattern (pattern : String) {
        NSUserDefaults.standardUserDefaults().setObject(pattern, forKey: "defaultPattern")
    }
    
    private func _getDefaultPattern () -> String? {
        return NSUserDefaults.standardUserDefaults().objectForKey("defaultPattern") as? String
    }
    
    private func _getPlayOrderIndexForPattern (pattern : String) -> Int {
        if let index = playOrderIndex[pattern] {
            return index
        } else {
            return 0
        }
    }
}