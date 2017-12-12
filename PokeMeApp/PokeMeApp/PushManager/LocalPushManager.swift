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
    
    func setUpLocalNotification(message: String, hm: String) {
        
        
        var array = hm.split(separator: ":")
        let hour = array[0]
        let minute = array[1]
        let hourInt = Int(hour)!
        let minuteInt = Int(minute)!
        
        // have to use NSCalendar for the components
        let calendar = NSCalendar(identifier: .gregorian)!;
        
        var dateFire = Date()
        
        // if today's date is passed, use tomorrow
        var fireComponents = calendar.components( [NSCalendar.Unit.day, NSCalendar.Unit.month, NSCalendar.Unit.year, NSCalendar.Unit.hour, NSCalendar.Unit.minute], from:dateFire)
        
        if (fireComponents.hour! > hourInt
            || (fireComponents.hour == hourInt && fireComponents.minute! >= minuteInt) ) {
            
            dateFire = dateFire.addingTimeInterval(86400)  // Use tomorrow's date
            fireComponents = calendar.components( [NSCalendar.Unit.day, NSCalendar.Unit.month, NSCalendar.Unit.year, NSCalendar.Unit.hour, NSCalendar.Unit.minute], from:dateFire);
        }
        
        // set up the time
        fireComponents.hour = hourInt
        fireComponents.minute = minuteInt
        
        // schedule local notification
        dateFire = calendar.date(from: fireComponents)!
        
        let localNotification = UILocalNotification()
        localNotification.fireDate = dateFire
        localNotification.alertBody = message
        localNotification.repeatInterval = NSCalendar.Unit.day
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        
        UIApplication.shared.scheduleLocalNotification(localNotification);
        
    }

}
