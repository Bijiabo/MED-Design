//
//  GlobalNavigationController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/12.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit

class GlobalNavigationController: UINavigationController {

    var operation : Operations?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
}
