//
//  AppDelegate.swift
//  MotherEncyclopedia
//
//  Created by bijiabo on 15/8/16.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        let navigationController : GlobalNavigationController = GlobalNavigationController()
        
        let CartoonDetailVC : cartoonDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("cartoonDetail") as! cartoonDetailViewController
        CartoonDetailVC.imageDirectoryPath = "cartoonImage/7"
        CartoonDetailVC.isStartVC = true
        
        let CartoonListButtonSize : (width : CGFloat , height : CGFloat) = (width : 70 , height : 70)
        
        let buttonForCartoonList : UIButton = UIButton(frame: CGRectMake(CartoonDetailVC.view.frame.size.width - 16.0 - CartoonListButtonSize.width , 30.0, CartoonListButtonSize.width, CartoonListButtonSize.height) )
        buttonForCartoonList.setImage(UIImage(named: "cartoonlist"), forState: UIControlState.Normal)
        buttonForCartoonList.addTarget(self, action: Selector("showCartoonList"), forControlEvents: UIControlEvents.TouchUpInside)
        
        CartoonDetailVC.view.addSubview(buttonForCartoonList)
        
        navigationController.viewControllers = [ CartoonDetailVC ]
        
        window?.rootViewController? = navigationController

        
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

    func loadModuleToNavigation (storyboardName : String , storyboardIdentifier : String)
    {
        let vc : UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(storyboardIdentifier) as UIViewController
        
        if let _ : DemoModule = vc as? DemoModule
        {
            var VC : DemoModule = vc as! DemoModule
            
            //VC.navigationDelegate = window?.rootViewController
        }
        
        (window?.rootViewController! as! UINavigationController) .pushViewController(vc, animated: true)
    }

    //显示漫画列表
    func showCartoonList ()
    {
        loadModuleToNavigation("Main", storyboardIdentifier: "cartoonList")
    }
}

