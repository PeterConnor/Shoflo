//
//  NextAirDate.swift
//  ReleaseDate
//
//  Created by Pete Connor on 5/27/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// refactor - done

import Foundation
import CoreData
import SwiftUI

class NextAirDate: ObservableObject {
    
    var managedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    let notificationManager = NotificationManager()
    var myShows = [MyShow]()
    var showDetail: DetailResponse?
    var showForAlert = "One of your favorite shows!"
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
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<MyShow>(entityName: "MyShow")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \MyShow.name, ascending: true)
        ]

        //3
        do {
            myShows = try managedContext.fetch(fetchRequest)
            for item in myShows {
                if item.air_date == nil || item.air_date == "N/A" {
                    getNextAirDate(show: item, backgroundTrueForegroundFalse: backgroundOrForegroundCheck)
                } else if item.air_date != nil && item.air_date != "N/A" {
                    if getDate(dateString: item.air_date!) != nil {
                        if getDate(dateString: item.air_date!)! < Date() || item.episode_number == 0 || item.episode_number > 1 {
                            item.air_date = nil
                            self.notificationManager.center.removePendingNotificationRequests(withIdentifiers: ["\(item.id)", "\(item.id)" + "2", "\(item.id)" + "3"])
                            do {
                                try self.managedContext.save()
                            } catch {

                            }
                        }
                    }
                }
            }
        } catch _ as NSError {
            //print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getNextAirDate(show: MyShow, backgroundTrueForegroundFalse: Bool) {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/\(show.id)?api_key=dd1fed7eede948d0697c67af77a4e3af&language=en-US") else { return }
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    do {
                        if let responseData = data {
                            let response = try JSONDecoder().decode(DetailResponse.self, from: responseData)
                            DispatchQueue.main.async {
                                self.showDetail = response
                                if response.next_episode_to_air?.air_date != nil {
                                    if response.next_episode_to_air?.episode_number != nil {
                                        if response.next_episode_to_air!.episode_number == 1 {
                                            //print(response.next_episode_to_air!.air_date)
                                            show.air_date = response.next_episode_to_air!.air_date
                                            self.notificationManager.scheduleNotification(myShow: show, date: self.notificationManager.getDate(dateString: response.next_episode_to_air!.air_date)!)
                                            
                                            if backgroundTrueForegroundFalse == true {
                                                //print("background true")
                                                self.notificationManager.scheduleImmediateNotification(myShow: show)
                                            } else {
                                                //print("foreground true")
                                                self.showForAlert = "\(show.name!)"
                                                self.newAirDateAndEnteredForeground = true
                                            }
                                            
                                        }
                                    }
                                } else {
                                    //print("No new air date")
                                }
                                if response.next_episode_to_air?.season_number != nil {
                                    show.season_number = Int32(response.next_episode_to_air!.season_number)
                                } else {
                                    //print("no new season number")
                                }
                                if response.next_episode_to_air?.episode_number != nil {
                                    show.episode_number = Int32(response.next_episode_to_air!.episode_number)
                                } else {
                                    //print("no new season number")
                                }
                                do {
                                    try self.managedContext.save()
                                } catch {
                                    //print("error saving managedObjectContext in detail view")
                                }
                            }
                        } else {
                        //print("No Data")
                        }
                    } catch {
                        //print(error)
                    }
                }
                .resume()
            }

}
