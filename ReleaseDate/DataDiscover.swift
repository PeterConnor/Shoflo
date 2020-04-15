//
//  DataDiscover.swift
//  ReleaseDate
//
//  Created by Pete Connor on 4/11/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

import SwiftUI
import CoreData

public class DiscoverServices: ObservableObject {
    
@Environment(\.managedObjectContext) var managedObjectContext

//    @FetchRequest(
//    entity: MyShow.entity(),
//    sortDescriptors: [
//        NSSortDescriptor(keyPath: \MyShow.name, ascending: true)
//    ]
//)

    var myShows = [MyShow]()
    
    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "MyShow")
     
    func fetchFunc() {
        do {
            myShows = try managedObjectContext.fetch(fetch) as! [MyShow]
           } catch {
               fatalError("Failed to fetch employees: \(error)")
           }
    }
    
@Published var shows = [Result]()
//@Published var query = "farscape"
    @Published var discoverNumber = 0 {
        didSet {
            load(num: self.discoverNumber, id: 71446)
            print(self.discoverNumber)
        }
    }
    
    var showID = 0
    
    @Published var myShowIndex = 0 {
        didSet {
            print(self.myShowIndex)
            //self.showID = Int(self.myShows[myShowIndex].id)
            print(showID)
            fetchFunc()
            print(myShows)
        }
    }

init() {
    load(num: 0, id: 71446)
}

    func load(num: Int, id: Int) {
    //todo - don't force unwrap all of these urls.
    let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        guard var url = URL(string: "https://api.themoviedb.org/3/tv/\(71446)/recommendations?api_key=\(apiKey)&language=en-US&page=1") else { return }
        switch discoverNumber {
        case 0:
            print("case 0 recommended")
            url = URL(string: "https://api.themoviedb.org/3/tv/\(71446)/recommendations?api_key=\(apiKey)&language=en-US&page=1")!
        case 1:
            print("case 1 popular")
            url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=\(apiKey)&language=en-US&page=1")!
        case 2:
            print("case 2 top rated")
            url = URL(string: "https://api.themoviedb.org/3/tv/top_rated?api_key=\(apiKey)&language=en-US&page=1")!
        default:
            print("default")
        }
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        do {
            if let d = data {
                let response = try JSONDecoder().decode(Response.self, from: d)
                DispatchQueue.main.async {
                    self.shows = response.results
                    print(response)
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
