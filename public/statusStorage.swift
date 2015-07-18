//
//  statusStorage.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/4/8.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import Foundation
/*
import SQLite

class statusStorage {
  
  let baseURL: NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath)!
  let fileManager : NSFileManager = NSFileManager.defaultManager()
  var isDir = ObjCBool(true)
  var db : Database!
  
  let id = Expression<Int64>("id")
  let name = Expression<String?>("name")
  let url = Expression<String?>("url")

  let status = Expression<String?>("status")
  let mediaUrl = Expression<String?>("mediaUrl")
  let mediaName = Expression<String?>("mediaName")
  let mode = Expression<String?>("mode")
  
  
  init(){
    let paths : NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    let documentsDirectory : NSString = paths.objectAtIndex(0) as NSString
    let documentSQLitePath : String = documentsDirectory.stringByAppendingPathComponent("SQLite")
    println("SQLite Path : \(documentSQLitePath)")

    if !fileManager.fileExistsAtPath( documentSQLitePath, isDirectory: &isDir)
    {
      fileManager.createDirectoryAtPath(documentSQLitePath, withIntermediateDirectories: false, attributes: nil, error: nil)
    }
    
    db = Database("\(documentSQLitePath)/db.sqlite3")
    
    let player = db["player"]
    
    db.create(table: player , ifNotExists : true) { t in
      t.column(self.id, primaryKey: true)
      t.column(self.status)
      t.column(self.mediaUrl)
      t.column(self.mediaName)
      t.column(self.mode)
    }
    
    if player.count == 0
    {
      if let playerInsertId = player.insert(status <- "play", mediaUrl <- "", mediaName <- "", mode <- "normal")
      {
        println("player insert id : \(playerInsertId)")
      }
    }
    else
    {
      println("SQLite[player] is alerdy exists:)")
    }
    
  }
  
  func updatePlayerData (#statusString:String, mediaUrlString:String, mediaNameString:String, modeString:String) -> Void {
    let player = db["player"]
    
    let playerQuery = player.filter(id == 1)
    playerQuery.update(status <- statusString, mediaUrl <- mediaUrlString, mediaName <- mediaNameString, mode <- modeString)?
  }
  
  
}
*/