//
//  AppDelegate.swift
//  GOceries
//
//  Created by Bram on 15/03/2022.
//
import UIKit
import IndoorAtlas

class IndoorAtlasManager: UIResponder, UIApplicationDelegate {
    
    func authenticateIALocationManager() {
        
        // Get IALocationManager shared instance
        let manager = IALocationManager.sharedInstance()
    
        // Set IndoorAtlas API key
        manager.setApiKey(apiKey, andSecret: apiSecret)
    }
}

