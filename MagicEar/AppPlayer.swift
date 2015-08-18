//
//  AppPlayer.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/8/18.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import Foundation


extension AppDelegate : PlayerOperation {
    
    func initPlayer() {
        let playerSource : NSURL = NSBundle.mainBundle().resourceURL!.URLByAppendingPathComponent("media/\(PlayerResources[0])")
        player = Player(source: playerSource)
        player.play()
        player.delegate = self
    }
    
    //MARK: PlayerOperation
    
    func play()
    {
        player.play()
        
        playing = true
        
        //sendPlayingStatusChangeNotification()
        
    }
    
    func pause()
    {
        player.pause()
        
        playing = false
        
        //sendPlayingStatusChangeNotification()
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
        //playNext()
        player.play()
    }
}