//
//  Module.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/12.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import Foundation

protocol ModuleLader
{
    func loadModule(storyboardName : String , storyboardIdentifier : String)
}

protocol Module
{
    var moduleLoader : ModuleLader? {get set}
}