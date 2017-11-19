//
//  LocalPushManager.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 19..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import UIKit
import UserNotifications

class LocalPushManager {
    
    static let shared = LocalPushManager()
    
    func sendLocalPush(title: String, text: String, time: TimeInterval = 5){
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.body = text
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: time, repeats: false)
        let request = UNNotificationRequest.init(identifier: "LocalPush", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            print(error?.localizedDescription)
        }
        print("Local push sent!")
    }

}
