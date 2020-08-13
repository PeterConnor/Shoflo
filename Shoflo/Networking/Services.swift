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
            //print("didSet shows - shows.count: \(shows.count)")
            imageList.removeAll()
            if shows.count > 0 {
                for (index, i) in shows.enumerated() {
                    getImage(path: i.poster_path ?? "", index: index)
                }
                //print("imageList.count: \(imageList.count)")
            }
        }
    }
     
    @Published var query: String = ""
    @Published var imageList: [UIImage?] = [UIImage]()
    
    init() {
        load()
    }
    
    func load() {
        let apiKey = "dd1fed7eede948d0697c67af77a4e3af"
        guard let url = URL(string: "https://api.themoviedb.org/3/search/tv?api_key=\(apiKey)&language=en-US&page=1&query=\(query.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil))&include_adult=false") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let d = data {
                    let response = try JSONDecoder().decode(Response.self, from: d)
                    DispatchQueue.main.async {
                        self.shows = response.results
                        
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
                            //print("finalImage changed")
                        }
                    } else {
                        //print("no image")
                    }
                } else {
                    //print("no data")
                }
                }
            } else {
                //print("no imageURL")
            }
        } else {
            //print("no imagePath")
        }
    }
}
