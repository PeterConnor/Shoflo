//
//  DataDetail.swift
//  ReleaseDate
//
//  Created by Pete Connor on 4/1/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

import SwiftUI

struct DetailResponse: Decodable {
    //backdrop_path to make it look good?
    let first_air_date: String
    let id: Int
    let in_production: Bool
    let name: String
    let next_episode_to_air: Next_Episode_To_Air?
    let networks: [Networks] // Need to add this to core data
    let number_of_seasons: Int
    let number_of_episodes: Int
    var origin_country: [String] // Didn't inlcude this in core data
    let overview: String
    let popularity: Float
    let status: String
    let poster_path: String
    let vote_average: Double
    let vote_count: Int
    let episode_run_time: [Int]
    let genres: [Genre]
    let original_language: String
    let last_episode_to_air: Last_Episode_To_Air
    let type: String
    
}

struct Next_Episode_To_Air: Decodable {
    let air_date: String
    let episode_number: Int
    let season_number: Int
}

struct Networks: Decodable {
    let name: String //todo - this might have more than one name, list of networks. need to test/find a show that has multiple.
}

struct Genre: Decodable {
    let name: String
}

struct Last_Episode_To_Air: Decodable {
    let air_date: String
}

class DetailServices: ObservableObject {
    @Published var showDetail: DetailResponse?
    @Published var showImage = UIImage()
    var showID: Int
    var poster_path: String?
    var vote_average: Double

    init(showID: Int, poster_path: String?, vote_average: Double) {
        self.showID = showID
        self.poster_path = poster_path
        self.vote_average = vote_average
        load()
        getImage(path: poster_path ?? "placeholder")
        //print("detailServices showID: \(showID)")
    }
    
    func load() {
        let apiKey = "dd1fed7eede948d0697c67af77a4e3af"
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/\(self.showID)?api_key=dd1fed7eede948d0697c67af77a4e3af&language=en-US"
) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    if let d = data {
                        let response = try JSONDecoder().decode(DetailResponse.self, from: d)
                        DispatchQueue.main.async {
                            self.showDetail = response
                            //print(response)
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
    
    func getImage(path: String) {
        if let imagePath = path as? String {
            //print(1)
            let imageURL = URL(string: "http://image.tmdb.org/t/p/w500" + imagePath)
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: imageURL!) {
                    //print(2)
                    if let image = UIImage(data: data) {
                        //print(3)
                        DispatchQueue.main.async {
                            //print(4)
                            self?.showImage = image
                        }
                    }
                }
            }
            //print(5)
            //I've tried returning a UIImage, which doesn't work.
        }
    }
}
