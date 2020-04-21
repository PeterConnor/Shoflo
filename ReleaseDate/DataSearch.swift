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
    @Published var shows = [Result]()
//        {
//        didSet {
//            print("shows.count: \(shows.count)")
//            imageList.removeAll()
//            if shows != nil {
//                for i in shows {
//                    getImage(path: i.poster_path ?? "no path")
//                    //imageList.append(UIImage(systemName: "magnifyingglass")) this was just to check to see if the for loop puts an image in each row, which it does.
//                }
//                print("imageList.count: \(imageList.count)")
//            }
//        }
//    }
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
    
//    for i in self.shows {
//        if let posterPath = i.poster_path as? String {
//            let imageUrl = URL(string: "http://image.tmdb.org/t/p/w500" + posterPath)
//            if let data = try? Data(contentsOf: imageUrl!) {
//                if let image = UIImage(data: data) {
//                self.showImage.append(image)
//                } else {
//                    print(1)
//                   self.showImage.append(UIImage(systemName: "magnifyingglass")!)
//                }
//            } else {
//                print(2)
//                self.showImage.append(UIImage(systemName: "magnifyingglass")!)
//            }
//        } else {
//            print(3)
//            self.showImage.append(UIImage(systemName: "magnifyingglass")!)
//        }
//    }
    func getImage(path: String?) -> UIImage {
        var finalImage: UIImage?
        if let imagePath = path as? String {
            print("step 1")
            if let imageURL = URL(string: "http://image.tmdb.org/t/p/w500" + imagePath) {
                print("here")
                print(imageURL)
            //DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: imageURL) {
                    print("step 2")
                    if let image = UIImage(data: data) {
                        print("step 3")
                        //DispatchQueue.main.async {
                            print("step 4")
                            //self?.imageList.append(image)
                            finalImage = image
                            print("finalImage changed")
                            //print("imageList: \(self?.imageList)")
                        //}
                    } else {
                        print("xxxno image")
                        //self?.imageList.append(UIImage(systemName: "hifispeaker"))
                        finalImage = UIImage(systemName: "hifispeaker")
                    }
                } else {
                    print("xxxno data")
                    //self?.imageList.append(UIImage(systemName: "printer"))
                    finalImage = UIImage(systemName: "printer")

                }
                //}
            } else {
                print("xxxno imageURL")
                //self.imageList.append(UIImage(systemName: "tv"))
                finalImage = UIImage(systemName: "tv")

            }
        } else {
            print("xxxno imagePath")
            //self.imageList.append(UIImage(systemName: "keyboard"))
            finalImage = UIImage(systemName: "keyboard")

        }
        return finalImage!
    }
    
}
