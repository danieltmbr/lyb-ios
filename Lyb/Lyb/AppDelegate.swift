//
//  AppDelegate.swift
//  Lyb
//
//  Created by Daniel Tombor on 2019. 05. 04..
//  Copyright © 2019. TransferWise. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController(nibName: nil, bundle: nil)
        window?.makeKeyAndVisible()
        print(Environment.current)
        return true
    }
}

