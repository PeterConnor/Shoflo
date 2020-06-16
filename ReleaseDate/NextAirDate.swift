//
//  NextAirDate.swift
//  ReleaseDate
//
//  Created by Pete Connor on 5/27/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

class NextAirDate: ObservableObject {
    
    var managedContext = NSManagedObjectContext()
    let notificationManager = NotificationManager()
    var myShows = [MyShow]()
    var myShowsNilAirDate = [MyShow]()
    var showDetail: DetailResponse?
    @Published var newAirDateAndEnteredForeground = false
    
    func getDate(dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let formattedDate = formatter.date(from: dateString) {
            return formattedDate
        } else {
            return nil
        }
    }
    
    func getCoreDataAndCheckNextAirDate(backgroundTrueForegroundFalse: Bool) {
    
        let backgroundOrForegroundCheck = backgroundTrueForegroundFalse
    //1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        managedContext = appDelegate.persistentContainer.viewContext

        //2
        let fetchRequest = NSFetchRequest<MyShow>(entityName: "MyShow")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \MyShow.name, ascending: true)
        ]

        //3
        do {
            myShows = try managedContext.fetch(fetchRequest)
            for i in myShows {
                if i.air_date == nil || i.air_date == "N/A" {
                    getNextAirDate(show: i, backgroundTrueForegroundFalse: backgroundOrForegroundCheck)
                } else if i.air_date != nil && i.air_date != "N/A" && i.episode_number != nil {
                    if getDate(dateString: i.air_date!) != nil {
                        if getDate(dateString: i.air_date!)! < Date() || i.episode_number == 0 || i.episode_number > 1 {
                            i.air_date = nil
                            self.notificationManager.center.removePendingNotificationRequests(withIdentifiers: ["\(i.id)", "\(i.id)" + "2", "\(i.id)" + "3"])
                            do {
                                try self.managedContext.save()
                            } catch {
                                "error saving managedObjectContext in detail view"
                            }
                        }
                    }
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getNextAirDate(show: MyShow, backgroundTrueForegroundFalse: Bool) {
        let apiKey = "dd1fed7eede948d0697c67af77a4e3af"
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/\(show.id)?api_key=dd1fed7eede948d0697c67af77a4e3af&language=en-US") else { return }
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    do {
                        if let d = data {
                            let response = try JSONDecoder().decode(DetailResponse.self, from: d)
                            DispatchQueue.main.async {
                                self.showDetail = response
                                if response.next_episode_to_air?.air_date != nil {
                                    if response.next_episode_to_air?.episode_number != nil {
                                        if response.next_episode_to_air!.episode_number == 1 {
                                            print(response.next_episode_to_air!.air_date)
                                            show.air_date = response.next_episode_to_air!.air_date
                                            self.notificationManager.scheduleNotification(myShow: show, date: self.notificationManager.getDate(dateString: response.next_episode_to_air!.air_date)!)
                                            
                                            if backgroundTrueForegroundFalse == true {
                                                print("background true")
                                                self.notificationManager.scheduleImmediateNotification(myShow: show)
                                            } else {
                                                print("foreground true")
                                                self.newAirDateAndEnteredForeground = true
                                            }
                                            
                                        }
                                    }
                                } else {
                                    print("No new air date")
                                }
                                if response.next_episode_to_air?.season_number != nil {
                                    show.season_number = Int32(response.next_episode_to_air!.season_number)
                                } else {
                                    print("no new season number")
                                }
                                if response.next_episode_to_air?.episode_number != nil {
                                    show.episode_number = Int32(response.next_episode_to_air!.episode_number)
                                } else {
                                    print("no new season number")
                                }
                                do {
                                    try self.managedContext.save()
                                } catch {
                                    "error saving managedObjectContext in detail view"
                                }
                                
                                
                            }
                        } else {
                        print("No Data")
                        }
                    } catch {
                        print(error)
                    }
                }
                .resume()
            }

}
