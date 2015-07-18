//
//  AppDelegate.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/4/3.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit
import Foundation
//import GCDWebServer
import AVFoundation
import AVKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , ModuleLader //, Operations , UIAlertViewDelegate ,
{
    //模拟蜂窝网络网络调试，设为`true`时，会识别网络为蜂窝网络。正式上线和测试产品时应为false。
    let isCellPhoneDebug : Bool = true
    
    var window: UIWindow?
    
    var webServer : GCDWebServer!
    
    
    var model : ModelManager!
    
    var player : PlayerManager!
    
    var nowPlayingInfoCenter : ViewManager!
    
    var cacheRootURL : NSURL!
    
    //MARK:
    //MARK: Network Operation
    
    var Wifi : Bool {
        get{
            return  IJReachability.isConnectedToNetworkOfType() == .WiFi
        }
    }
    
    var Connected : Bool {
        get{
            return IJReachability.isConnectedToNetwork()
        }
    }
    
    var CellularNetwork : Bool {
        return isCellPhoneDebug ? true : IJReachability.isConnectedToNetworkOfType() == .WWAN
    }
    
    //MARK:
    //MARK: 检测网络变化
    let reachability = Reachability.reachabilityForInternetConnection()

    
    //var statusStorageInstance : statusStorage!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        
        let baseURL: NSURL = NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath)!
        
        //webServer -----------------------

        //获取Documents目录路径
        let paths : NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory : NSString = paths.objectAtIndex(0) as! NSString
        let documentWebPath : String = documentsDirectory.stringByAppendingPathComponent("web")
        
        let fileManager : NSFileManager = NSFileManager.defaultManager()
        var isDir = ObjCBool(true)
        if !fileManager.fileExistsAtPath( documentWebPath, isDirectory: &isDir)
        {
            //若document目录下存在web目录，创建
            fileManager.createDirectoryAtPath(documentWebPath, withIntermediateDirectories: false, attributes: nil, error: nil)
        }
        
        let srcWebUrl : NSURL! = baseURL.URLByAppendingPathComponent("web")
        let srcWebPath : String = NSBundle.mainBundle().bundlePath.stringByAppendingPathComponent("web")
        
        println(srcWebPath)
        
        webServer = GCDWebServer()
        webServer.addGETHandlerForBasePath("/", directoryPath: srcWebPath, indexFilename: nil, cacheAge: 3600, allowRangeRequests: true)
        webServer.startWithPort(8080, bonjourName: "childFM")
        
        NSNotificationCenter.defaultCenter().postNotificationName("webServerStarted", object: nil)
        
        sleep(1)
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //Module Loader Protocol
    
    func loadModule(storyboardName: String, storyboardIdentifier: String) {
        
        var mainVC : UIViewController!
        
        switch storyboardName
        {
            
        case "Main":
            mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(storyboardIdentifier) as! UIViewController
            
            
        default:
            break
        }
        
        self.window?.rootViewController?.presentViewController(mainVC, animated: true, completion: nil)
        
    }
    
    //MARK:
    //MARK: ViewOperation
    
    func doLike() {
        
    }
    
    func doDislike() {
        playNext()
    }
    
    func wrongPlayerUrl() {
        
    }
    
    
    func switchToScene(scene : String)
    {
        model.status.set_CurrentScene(scene)
    }
    
    func playNext()
    {
        model.next()
    }
    
    func updateChildInformation()
    {
        
    }
    
    //播放器播放状态改变发送一个通知
    func sendPlayingStatusChangeNotification()
    {
        NSNotificationCenter.defaultCenter().postNotificationName("PlayingStatusChanged", object: playing)
    }
    
    //MARK:
    //MARK: PlayerOperation
    
    var playing : Bool = false
    
    func play()
    {
        player.play()
        
        playing = true
        
        sendPlayingStatusChangeNotification()
        
    }
    
    func pause()
    {
        player.pause()
        
        playing = false
        
        sendPlayingStatusChangeNotification()
    }
    
    func togglePlayPause()
    {
        if playing
        {
            pause()
        }
        else
        {
            play()
        }
    }
    
    func playerDidFinishPlaying()
    {
        playNext()
    }
    
    //MARK:
    //MARK: 播放内容更新
    //MARK: 2遍播放问题所在，应去除。
    /*
    func currentPlayingDataHasChanged() {
        
        if currentMediaFileExist()
        {
            let mediaFileURL : NSURL = cacheRootURL.URLByAppendingPathComponent(model?.currentPlayingData["localURI"] as! String)
            
            if player != nil
            {
                player.setSource(mediaFileURL)
            }
            else
            {
                player = Player(source: mediaFileURL)
            }
            
            if playing
            {
                play()
            }
            
            //处理音频无法播放bug，跳至下一首
            if player == nil
            {
                model.next()
            }
            
        }
        else
        {
            let mediaRemoteURLString : String = (model.currentPlayingData["remoteURL"] as! [String])[0]
            
            let filename : String? = model?.currentPlayingData["localURI"] as? String
            
            singleMediaNeedToDownload(remoteURL: mediaRemoteURLString, filename: filename)
            
            model.next()
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("CurrentPlayingDataHasChanged", object: nil)
    }
    */
    
    //MARK:
    //MARK: 读取数据，并将其他格式数据转换为原生数组
    func loadJSONData(dataFilename : String) -> JSON
    {
        //读取文件内容
        let dataRootURL : NSURL = NSBundle.mainBundle().resourceURL!.URLByAppendingPathComponent("resource/data")
        
        let dataFileData : NSData = NSData(contentsOfURL: dataRootURL.URLByAppendingPathComponent( dataFilename ))!
        
        let dataFileJSON : JSON = JSON(data:dataFileData)
        
        return dataFileJSON
    }
    
    //将json格式数据转换为原生数组
    func convertJSONtoArray (jsonData : JSON) -> [Dictionary<String,AnyObject>]
    {
        //所有数据
        var data : [Dictionary<String,AnyObject>] = [Dictionary<String,AnyObject>]()
        
        for (key:String,subJSON:JSON) in jsonData
        {
            var item : Dictionary<String,AnyObject> = Dictionary<String,AnyObject>()
            
            //[name:"起床", list:[ item0, item1, item2... ] ]
            for (key_1:String,subJSON_1:JSON) in subJSON
            {
                
                if let value = subJSON_1.string//判断场景名,[起床,午后,玩耍,睡前]
                {
                    item[key_1] = value//存场景名字
                }
                else
                {
                    //继续遍历:对应场景的音乐
                    var scenelist : [Dictionary<String,AnyObject>] = [Dictionary<String,AnyObject>]()
                    
                    for (key_2:String, subJSON_2:JSON) in subJSON_1
                    {
                        scenelist.append(subJSON_2.dictionaryObject!)
                    }
                    
                    item[key_1] = scenelist//存对应场景的列表???稍微不理解,上面存得是string类型,这里是json类型$$$
                }
                
            }
            
            data.append(item)
        }
        
        return data
    }
    
    //检测文件是否存在
    func currentMediaFileExist () -> Bool
    {
        var isNotDir : ObjCBool = false
        let mediaFileURL : NSURL = cacheRootURL.URLByAppendingPathComponent(model?.currentPlayingData["localURI"] as! String)
        
        if NSFileManager.defaultManager().fileExistsAtPath(mediaFileURL.relativePath!, isDirectory: &isNotDir)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    //MARK:
    //MARK: 下载相关
    /*
    //下载Item的id队列，用于检测是否所有下载已完成
    var downloadQueue : [Dictionary<String,String?>] = [Dictionary<String,String?>]()
    //单个文件下载队列
    var mediaFilesNeedToDownloadQueue : [Dictionary<String,String?>] = [Dictionary<String,String?>]()
    
    func singleMediaNeedToDownload(#remoteURL : String , filename : String?)
    {
        mediaFilesNeedToDownloadQueue.append([
            "remoteURL" : remoteURL,
            "filename" : filename
            ])
        
        if CellularNetwork
        {
            //蜂窝网络环境，申请用户下载许可
            showDownloadAlert(allDownload: false)
        }
        else
        {
            //直接下载
            downloadMediaFilesInQueue()
        }
        
    }
    
    func downloadMediaFilesInQueue ()
    {
        for i in 0..<mediaFilesNeedToDownloadQueue.count
        {
            let remoteURL : String = mediaFilesNeedToDownloadQueue[i]["remoteURL"]!!
            let filename : String? = mediaFilesNeedToDownloadQueue[i]["filename"]!
            let id : Int? = downloader?.addTask(remoteURL, cacheRootURL: cacheRootURL, filename : filename )
            
            //更新总体下载队列暂存
            addTaskRecordsToDownloadQueue([
                "remoteURL" : remoteURL,
                "filename" : filename
                ])
            
            
            NSNotificationCenter.defaultCenter().postNotificationName("NeedsToDownloadMediaFile", object: id)
        }
        
        downloader?.startDownload()
        
        mediaFilesNeedToDownloadQueue.removeAll(keepCapacity: false)
    }
    
    //记录下载任务至下载队列，便于总体下载状态统计，是否已经全部完成
    func addTaskRecordsToDownloadQueue(item : Dictionary<String,String?>)
    {
        var aleardyHasTask : Bool = false
        
        for item in downloadQueue
        {
            let sameRemoteURL : Bool = item["remoteURL"]! == item["remoteURL"]!
            let sameFilename : Bool = item["filename"]! == item["filename"]!
            
            if sameRemoteURL && sameFilename
            {
                aleardyHasTask = true
                break
            }
        }
        
        if aleardyHasTask == false
        {
            println("aleardyHasTask == false")
            downloadQueue.append(item)
        }
    }
    
    
    //枚举：下载提示alertView绑定动作
    enum DownloadAlertAction : Int
    {
        //下载全部
        case downloadAll
        //下载当前所需
        case downloadCurrentMedia
    }
    
    //显示下载提示
    var downloadAlertView : UIAlertView = UIAlertView()
    var downloadAlertViewIsShowing : Bool = false
    
    func showDownloadAlert(#allDownload : Bool)
    {
        if downloadAlertViewIsShowing {
            return
        }
        
        let tittle : String = "下载媒体资源"
        let message : String = "检测到您的设备处于蜂窝网络环境下，是否继续下载相关的媒体资源？"
        
        downloadAlertView = UIAlertView(title: tittle, message: message, delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "下载")
        
        if allDownload
        {
            downloadAlertView.tag = DownloadAlertAction.downloadAll.rawValue
        }
        else
        {
            downloadAlertView.tag = DownloadAlertAction.downloadCurrentMedia.rawValue
        }
        
        downloadAlertView.show()
        downloadAlertViewIsShowing = true
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if alertView.tag == DownloadAlertAction.downloadCurrentMedia.rawValue
        {
            if buttonIndex == 1
            {
                //下载媒体资源
                downloadMediaFilesInQueue()
            }
        }
        else if alertView.tag == DownloadAlertAction.downloadAll.rawValue
        {
            //下载全部媒体资源
            if buttonIndex == 1
            {
                //用户确认点击了下载按钮
                startAllDownload()
            }
        }
        
        downloadAlertViewIsShowing = false
    }
    
    */
    //MARK:
    //MARK: Download Operation Protocol
    /*
    func startAllDownload() {
        
        //获取下载列表
        let downloadList : [Dictionary<String,String>] = model.getDownloadList()
        
        //下载全部媒体文件
        for item in downloadList
        {
            let remoteURL : String = item["remoteURL"]!
            let filename : String? = item["filename"]
            
            downloader?.addTask(remoteURL, cacheRootURL: cacheRootURL, filename: filename)
            
            //更新总体下载进度暂存
            addTaskRecordsToDownloadQueue([
                "remoteURL" : remoteURL,
                "filename" : filename
                ])
        }
        
        downloader?.startDownload()
        
        //记录 用户已经选择下载过全部内容
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasDownloadAllMediaFiles")
    }
    
    //MARK:
    //MARK: download observer protocol
    
    //下载完成
    func downloadCompleted(data : AnyObject)
    {
        if let downloadItem : DownloadItemProtocol = data as? DownloadItemProtocol
        {
            for var i = 0 ; i < downloadQueue.count ; i++
            {
                let item = downloadQueue[i]
                let sameRemoteURL : Bool = NSURL(string: item["remoteURL"]!!)! == downloadItem.remoteURL
                let sameFilename : Bool = item["filename"]! == downloadItem.filename
                
                if sameRemoteURL && sameFilename
                {
                    downloadQueue.removeAtIndex(i)
                    break
                }
            }
        }
        
        println("downloadItemIdQueue.count \(downloadQueue.count)")
        
        if downloadQueue.count == 0
        {
            NSNotificationCenter.defaultCenter().postNotificationName("DownloadStoped", object: nil)
        }
    }
    
    //下载出错
    func downloadErrorOccurd(data : AnyObject)
    {
        
    }
    
    
    func addObserver()
    {
        //年龄改变
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("ageChanged:"), name: "childAgeGroupChanged", object: nil)
        
        //主播放界面加载完毕
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("mainPlayerViewControllerDidLoad:"), name: "MainPlayerViewControllerDidLoad", object: nil)
    }
    
    func ageChanged (notification : NSNotification)
    {
        let ageObject : Dictionary<String,Int> = notification.object as! Dictionary<String,Int>
        var age : Int = ageObject["age"]!
        
        //MARK: 调试，超过三岁的暂用6岁数据
        if age>3 {age = 6}
        
        println("age : \(age)")
        
        let jsonData : JSON = loadJSONData("6.json")
        var data = convertJSONtoArray(jsonData)
        
        model.updateData(data)
    }
    
    func mainPlayerViewControllerDidLoad (notification : NSNotification)
    {
        //若之前没有下载过内容，则自动下载
        if NSUserDefaults.standardUserDefaults().boolForKey("hasDownloadAllMediaFiles") == false || isCellPhoneDebug
        {
            if CellularNetwork
            {
                showDownloadAlert(allDownload: true)
            }
            else
            {
                startAllDownload()
            }
        }
    }
    */
    

}
