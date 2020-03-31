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
    var id: Int
    let name: String?
    let poster_path: String?
}


public class Services: ObservableObject {
    @Published var shows = [Result]()
    @Published var query = "farscape"
    @Published var showImage = UIImage(systemName: "magnifyingglass")
    
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
                        //print("shows: \(self.shows)")
                        print("decoded: \(response.results)")
                        for i in self.shows {
                            if let posterPath = i.poster_path as? String {
                                let imageUrl = URL(string: "http://image.tmdb.org/t/p/w500" + posterPath)
                                if let data = try? Data(contentsOf: imageUrl!) {
                                    if let image = UIImage(data: data) {
                                        self.showImage = image
                                        print(self.showImage)
                                    }
                                }
                                
                            }
                            
                            
                            
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

