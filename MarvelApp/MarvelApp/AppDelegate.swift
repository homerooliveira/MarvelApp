//
//  AppDelegate.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 04/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let target = MarvelApi.characters(offset: 0)
        MarvelApiProvider()
            .request(for: target) { (result: Result<CharacterDataWrapper>) in
            print(result)
        }
        return true
    }

}

