//
//  Data.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/25/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

import SwiftUI

struct Show: Decodable, Identifiable {
    public var id: Int
    public var name: String
}

public class Fetcher: ObservableObject {
    @Published var shows = [Show]()
    @Published var query = "ozark"
    
    init() {
        load()
    }
    
    func load() {
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/69740?api_key=\(apiKey)&language=en-US") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let d = data {
                    let decodedLists = try JSONDecoder().decode(Show.self, from: d)
                    DispatchQueue.main.async {
                        self.shows = [decodedLists]
                        //print(self.shows[0].name)
                        //print((type(of: self.shows)))
                        //print(type(of: decodedLists))
                    }
                } else {
                print("No Data")
                }
            } catch {
                print(error.localizedDescription)
            }

        }
        .resume()
    }
}
