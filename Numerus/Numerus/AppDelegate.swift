//
//  AppDelegate.swift
//  Numerus
//
//  Created by Armando Di Cianno on 5/16/16.
//  Copyright © 2016 Armando Di Cianno. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - properties
    
    /*
     Setup a navigation controller as the root view controller. It's own root view controller
     will be the "main" view controller of the app. This ensures the extended layout edges are
     easily used in sane ways, and also let's use have a convenient area for setting a title.
     */
    fileprivate var navController: MainNavigationController!
    fileprivate var viewController: MainViewController!
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.viewController = MainViewController()
        self.navController  = MainNavigationController(rootViewController: self.viewController)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.navController
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        return true
    }

}
