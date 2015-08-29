//
//  MiiPlayer.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/8/28.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import Foundation
import AVFoundation

class MiiPlayer: NSObject {
    
    private var _player : AVAudioPlayer = AVAudioPlayer()
    
    override init() {
        super.init()
    }
    
    func play () {
        _player.play()
    }
    
    func pause () {
        _player.pause()
    }
    
    func setResourceByURL (url : NSURL) {
        do {
            _player = try AVAudioPlayer(contentsOfURL: url)
        }catch let error as NSError {
            print(error)
        }
    }
    
    func getResourceURL () -> NSURL? {
        return _player.url
    }
}