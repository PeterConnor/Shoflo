//
//  NotificationManager.swift
//  ReleaseDate
//
//  Created by Pete Connor on 5/14/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

import UserNotifications

class NotificationManager {
    
    //Does this let the user tap the notification to be taken into the app?
    
    let center = UNUserNotificationCenter.current()

    func requestNotificationAuthorization() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Success")
            } else {
                print("Failure")
            }
        }
    }

    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        //pass these into the function as parameters
        content.title = "Title"
        content.body = "Body"
        content.categoryIdentifier = "alarm" //Do I need this?
        content.userInfo = ["customData": "fizzbuzz"] //Do I need this?
        content.sound = UNNotificationSound.default //Do I need this?

        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.month = 5
        dateComponents.day = 16
        dateComponents.hour = 13
        dateComponents.minute = 30
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
}


