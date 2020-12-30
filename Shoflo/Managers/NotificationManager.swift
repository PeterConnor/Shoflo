//
//  NotificationManager.swift
//  ReleaseDate
//
//  Created by Pete Connor on 5/14/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

import UserNotifications

class NotificationManager: ObservableObject {
        
    var isAuthorized: Bool? = nil
    
    let center = UNUserNotificationCenter.current()
    
    func getDate(dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let formattedDate = formatter.date(from: dateString) {
            return formattedDate
        } else {
            return nil 
        }
    }
    
    func getDateString(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let formattedDate = formatter.date(from: dateString) {
            formatter.dateFormat = "MMM d, yyyy"
            return formatter.string(from: formattedDate)
        } else {
            return "N/A"
        }
    }

    func requestNotificationAuthorization() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                //print("Success")
                self.isAuthorized = true
            } else {
                //print("Notification Not Authorized")
                self.isAuthorized = false
            }
        }        
    }

    func scheduleNotification(myShow: MyShow, date: Date) {

        requestNotificationAuthorization()
        
        let content = UNMutableNotificationContent()
        content.title = "\(myShow.name!)"
        content.body = "The first episode of a new season of \(myShow.name!) is scheduled to air on \(getDateString(dateString: myShow.air_date!))"
        content.sound = .default
        
        let subtractedDate = Calendar.current.date(byAdding: .day, value: -1, to: date)
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: subtractedDate!)
        var dateComponents = DateComponents()
        dateComponents.year = calendarDate.year
        dateComponents.month = calendarDate.month
        dateComponents.day = calendarDate.day
        dateComponents.hour = 18
        dateComponents.minute = 30
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "\(myShow.id)", content: content, trigger: trigger)
        center.add(request) { (error: Error?) in
            
            if error == nil {
                //print("Notification Scheduled", trigger ?? "Date Nil")
            } else {
                //print("Error scheduling notification", error?.localizedDescription ?? "")
            }
        }
        
        let subtractedDate2 = Calendar.current.date(byAdding: .day, value: -7, to: date)
        let calendarDate2 = Calendar.current.dateComponents([.day, .year, .month], from: subtractedDate2!)
        var dateComponents2 = DateComponents()
        dateComponents2.year = calendarDate2.year
        dateComponents2.month = calendarDate2.month
        dateComponents2.day = calendarDate2.day
        dateComponents2.hour = 18
        dateComponents2.minute = 30
        
        let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponents2, repeats: false)
        let request2 = UNNotificationRequest(identifier: "\(myShow.id)" + "2", content: content, trigger: trigger2)
        center.add(request2) { (error: Error?) in
            
            if error == nil {
                //print("Notification Scheduled", trigger ?? "Date Nil")
            } else {
                //print("Error scheduling notification", error?.localizedDescription ?? "")
            }
        }
        
        let subtractedDate3 = Calendar.current.date(byAdding: .day, value: -30, to: date)
        let calendarDate3 = Calendar.current.dateComponents([.day, .year, .month], from: subtractedDate3!)
        var dateComponents3 = DateComponents()
        dateComponents3.year = calendarDate3.year
        dateComponents3.month = calendarDate3.month
        dateComponents3.day = calendarDate3.day
        dateComponents3.hour = 18
        dateComponents3.minute = 30
        
        let trigger3 = UNCalendarNotificationTrigger(dateMatching: dateComponents3, repeats: false)
        let request3 = UNNotificationRequest(identifier: "\(myShow.id)" + "3", content: content, trigger: trigger3)
        center.add(request3) { (error: Error?) in
            
            if error == nil {
                //print("Notification Scheduled", trigger ?? "Date Nil")
            } else {
                //print("Error scheduling notification", error?.localizedDescription ?? "")
            }
        }
    }
    
    @Published var notificationsOff = false
    
    func checkNotificationsSettingsAuthorizationStatus() {
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                if settings.authorizationStatus == .authorized {
                    //print("authorized")
                    self.notificationsOff = false
                } else {
                    //print("not authorized")
                    self.notificationsOff = true
                }
            }
        }
    }
    
//    func getPending() {
//        self.center.getPendingNotificationRequests(completionHandler: { requests in
//            //print("pending notifications...")
//            for request in requests {
//                print("notreq: \(request)")
//            }
//        })
//    }
    
    func scheduleImmediateNotification(myShow: MyShow) {
        //print("scheduleImmediateNotification")
        
        requestNotificationAuthorization()
        
        let content = UNMutableNotificationContent()
        content.title = "\(myShow.name!)"
        content.body = "The first episode of a new season of \(myShow.name!) is scheduled to air on \(getDateString(dateString: myShow.air_date!))"
        content.sound = .default

        let date = Date()
        let subtractedDate = Calendar.current.date(byAdding: .minute, value: 1, to: date)
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month, .hour, .minute], from: subtractedDate!)
        var dateComponents = DateComponents()
        dateComponents.year = calendarDate.year
        dateComponents.month = calendarDate.month
        dateComponents.hour = calendarDate.hour
        dateComponents.minute = calendarDate.minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "immediate", content: content, trigger: trigger)
        center.add(request) { (error: Error?) in
            
            if error == nil {
                //print("Notification Scheduled", trigger ?? "Date Nil")
            } else {
                //print("Error scheduling notification", error?.localizedDescription ?? "")
            }
        }
        
    }
}
