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
            if let imageURL = URL(string: "http://image.tmdb.org/t/p/w500" + imagePath) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: imageURL) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.imageList[index] = image
                            print("finalImage changed")
                        }
                    } else {
                        print("xxxno image")
                    }
                } else {
                    print("xxxno data")
                }
                }
            } else {
                print("xxxno imageURL")
            }
        } else {
            print("xxxno imagePath")
        }
    }
}
