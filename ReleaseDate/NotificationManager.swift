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
    
    var isAuthorized: Bool? = nil
    
    let center = UNUserNotificationCenter.current()

    func requestNotificationAuthorization() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Success")
                self.isAuthorized = true
            } else {
                print("Notification Not Authorized")
                self.isAuthorized = false
            }
        }
        
        //center.delegate = self do i need this?
    }

    func scheduleNotification(myShow: MyShow, date: Date) {
        
        //once this works, i need to put date: Date parameter into this fuction (like in outfit tracker), so it fires off of the show next air date.
        
        requestNotificationAuthorization()
        
        let content = UNMutableNotificationContent()
        //pass these into the function as parameters
        content.title = "\(myShow.name ?? "Show Update")"
        content.body = "The first episode of a new season of \(myShow.name) is scheduled to air on \(date)"
        //content.categoryIdentifier = "alarm" //Do I need this?
        //content.userInfo = ["customData": "fizzbuzz"] //Do I need this?
        //content.sound = UNNotificationSound.default //Do I need this?

        
        let subtractedDate = Calendar.current.date(byAdding: .day, value: -9, to: date)
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: subtractedDate!)
        
        var dateComponents = DateComponents()
        dateComponents.year = calendarDate.year
        dateComponents.month = calendarDate.month
        dateComponents.day = calendarDate.day
        dateComponents.hour = 23
        dateComponents.minute = 21
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(identifier: "1", content: content, trigger: trigger)
        //need to make the identifier ShowID
        
        center.add(request) { (error: Error?) in
            
            if error == nil {
                print("Notification Scheduled", trigger ?? "Date Nil")
            } else {
                print("Error scheduling notification", error?.localizedDescription ?? "")
            }
        }
    }
}


/*
 
 let date = Date()

 let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
 let newDate = Calendar.current.date(byAdding: .day, value: -30, to: Date())
 print(calendarDate)
 print(newDate)
 print("Hello")
 
 */
