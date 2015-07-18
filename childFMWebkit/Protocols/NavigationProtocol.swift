//
//  NavigationProtocol.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/14.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import Foundation

protocol NavigationProtocol
{
    func loadModuleToNavigation (storyboardName : String , storyboardIdentifier : String)
}

protocol DemoModule
{
    var navigationDelegate : NavigationProtocol? {get set}
}