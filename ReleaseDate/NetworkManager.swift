//
//  NetworkManager.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/22/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

//import Foundation
//import SwiftUI
//
//class NetworkManager {
//
//    var movies: [NSDictionary]?
//    var query = "hello"
//
//    func getReleaseDate() {
//        //NEED TO MAKE THIS GUARD. CLEAN UP.
//        // ozard id = 69740
//        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
//        let url = URL(string: "https://api.themoviedb.org/3/tv/69740?api_key=\(apiKey)&language=en-US")
//        let searchURL = URL(string: "https://api.themoviedb.org/3/search/tv?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1&query=\(query)&include_adult=false")
//
//        let request = URLRequest(url: searchURL! as URL)
//        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
//
//        let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
//            if let data = data {
//                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
//                           //print("\(responseDictionary)")
//
//                    self.movies = responseDictionary["results"] as? [NSDictionary]
//                       }
//                   }
//               })
//           task.resume()
//           }
//    }
    

