//
//  DataSearch.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/26/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

import SwiftUI

struct Response: Decodable {
    public var results: [Result]
}


struct Result: Decodable, Identifiable {
    let id: Int
    let name: String?
    let poster_path: String?
    let vote_average: Double
    let overview: String?
}


public class Services: ObservableObject {
    @Published var shows = [Result]() {
        didSet {
            print("didSet shows - shows.count: \(shows.count)")
            imageList.removeAll()
            if shows.count > 0 {
                for (index, i) in shows.enumerated() {
                    getImage(path: i.poster_path ?? "", index: index)
                    //imageList.append(UIImage(systemName: "magnifyingglass")) this was just to check to see if the for loop puts an image in each row, which it does.
                }
                //print("imageList.count: \(imageList.count)")
            }
        }
    }
    @Published var query = "farscape"
    @Published var imageList: [UIImage?] = [UIImage]()
    
    init() {
        load()
        
    }
    
    func load() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        guard let url = URL(string: "https://api.themoviedb.org/3/search/tv?api_key=\(apiKey)&language=en-US&page=1&query=\(query)&include_adult=false") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let d = data {
                    let response = try JSONDecoder().decode(Response.self, from: d)
                    DispatchQueue.main.async {
                        self.shows = response.results
                        
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
    
    func getImage(path: String?, index: Int) {
        var finalImage = UIImage(systemName: "wifi.slash")
            imageList.append(finalImage)
        if let imagePath = path as? String {
            //print("step 1")
            if let imageURL = URL(string: "http://image.tmdb.org/t/p/w500" + imagePath) {
                //print("here")
                //print(imageURL)
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: imageURL) {
                    //print("step 2")
                    if let image = UIImage(data: data) {
                        //print("step 3")
                        DispatchQueue.main.async {
                            //print("step 4")
                            //finalImage = image
                            self?.imageList[index] = image

                            //print("finalImage changed")
                        }
                    } else {
                        //print("xxxno image")
                        //finalImage = UIImage(systemName: "hifispeaker")
                    }
                } else {
                    //print("xxxno data")
                    //finalImage = UIImage(systemName: "printer")
                }
                }
            } else {
                print("xxxno imageURL")
                //finalImage = UIImage(systemName: "tv")
            }
        } else {
            print("xxxno imagePath")
            //finalImage = UIImage(systemName: "keyboard")
        }
    }
    
}
