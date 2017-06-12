//
//  AppDelegate.swift
//  GoogleMaps
//
//  Created by kateryna.zaikina on 5/25/17.
//  Copyright © 2017 kateryna.zaikina. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyDTP5McVzN4ZobSyAlM-lhWe3zXD7NbuG8")
        return true
    }
    
    


}

