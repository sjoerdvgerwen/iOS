//
//  GOceriesApp.swift
//  GOceries
//
//  Created by Bram on 16/02/2022.
//

import SwiftUI

@main
struct GOceriesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        IndoorAtlasManager().authenticateIALocationManager()
        
        return true
    }
}
