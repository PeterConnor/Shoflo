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
    
    var myShows = [MyShow]()
  
    func getCoreData() {
  //1
        guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext =
        appDelegate.persistentContainer.viewContext

        //2
        let fetchRequest =
        NSFetchRequest<MyShow>(entityName: "MyShow")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \MyShow.name, ascending: true)
        ]

        //3
        do {
            myShows = try managedContext.fetch(fetchRequest)
            ////print("myshows: \(myShows)")
        } catch _ as NSError {
            //print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
        
    @Published var shows = [Result]() {
        didSet {
            ////print("didSet shows - shows.count: \(shows.count)")
            imageList.removeAll()
            if shows.count > 0 {
                for (index, i) in shows.enumerated() {
                    getImage(path: i.poster_path ?? "", index: index)
                    //imageList.append(UIImage(systemName: "magnifyingglass")) this was just to check to see if the for loop puts an image in each row, which it does.
                }
                ////print("imageList.count: \(imageList.count)")
            }
        }
    }
    @Published var imageList: [UIImage?] = [UIImage]()

    
    //@Published var query = "farscape"

    @Published var discoverNumber = 0 {
            didSet {
                //print("this did change")
                load(num: self.discoverNumber, id: showID)
                ////print(self.discoverNumber)
            }
        }
    
    var showID = 0
    
    @Published var myShowIndex = 0 {
        didSet {
            getCoreData()
            //print("myshowindex: \(self.myShowIndex)")
            ////print(myShows.count)
            if myShows.count > 0 /*&& myShows != nil*/ {
               self.showID = Int(self.myShows[myShowIndex].id)
            }
            
            ////print(showID)
            load(num: self.discoverNumber, id: showID)
        }
    }

init() {
    getCoreData()
    if myShows != [] {
        self.showID = Int(self.myShows[myShowIndex].id)
    }
    load(num: 0, id: showID)
}

    func load(num: Int, id: Int) {
    //todo - don't force unwrap all of these urls.
    let apiKey = "dd1fed7eede948d0697c67af77a4e3af"
        guard var url = URL(string: "https://api.themoviedb.org/3/tv/\(showID)/recommendations?api_key=\(apiKey)&language=en-US&page=1") else { return }
        switch discoverNumber {
        case 0:
            //print("case 0 recommended")
            url = URL(string: "https://api.themoviedb.org/3/tv/\(showID)/recommendations?api_key=\(apiKey)&language=en-US&page=1")!
        case 1:
            //print("case 1 popular")
            url = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=\(apiKey)&language=en-US&page=1")!
        case 2:
            //print("case 2 top rated")
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
                    ////print(response)
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
    
  func getImage(path: String?, index: Int) {
        let finalImage = UIImage(named: "imagenotavailable")
            imageList.append(finalImage)
            if let imagePath = path {
                if let imageURL = URL(string: "http://image.tmdb.org/t/p/w500" + imagePath) {
                    DispatchQueue.global().async { [weak self] in
                        if let data = try? Data(contentsOf: imageURL) {
                            if let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self?.imageList[index] = image
                                    ////print("finalImage changed")
                        }
                    } else {
                        //print("xxxno image")
                    }
                } else {
                    //print("xxxno data")
                }
                }
            } else {
                //print("xxxno imageURL")
            }
        } else {
            //print("xxxno imagePath")
        }
    }
    
    
}
