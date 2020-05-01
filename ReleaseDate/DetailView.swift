//
//  DetailView.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/31/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var detailServices: DetailServices
    @Environment(\.managedObjectContext) var managedObjectContext

    var name: String
    
    var body: some View {
        VStack {
            Group {
                Text(name)
                    .fontWeight(.black)
                    .font(.largeTitle)
                Image(uiImage: detailServices.showImage)
                    .resizable()
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 5)
                    .padding(20)
                Text("Rating: \(detailServices.vote_average, specifier: "%.1f")")
                Text("Next Episode Air Date: \(detailServices.showDetail?.next_episode_to_air?.air_date ?? "N/A")")
                
                if detailServices.showDetail?.next_episode_to_air?.episode_number != nil {
                   Text("Next Episode Number: \(detailServices.showDetail!.next_episode_to_air!.episode_number)")
                } else {
                    Text("N/A")
                }
                
                if detailServices.showDetail?.next_episode_to_air?.season_number != nil {
                    Text("Next Season Number: \(detailServices.showDetail!.next_episode_to_air!.season_number)")
                } else {
                    Text("N/A")
                }
                //I probably need to combine season number and ep number for next episode?
                if detailServices.showDetail?.number_of_seasons != nil {
                    Text("Number of Seasons: \(detailServices.showDetail!.number_of_seasons)")
                } else {
                    Text("N/A")
                }
                if detailServices.showDetail?.popularity != nil {
                    Text("Popularity: \(detailServices.showDetail!.popularity)")
                } else {
                    Text("N/A")
                }
                Text("Status: \(detailServices.showDetail?.status ?? "N/A")")

            }
            Group {
                if detailServices.showDetail?.in_production != nil {
                    if detailServices.showDetail?.in_production == true {
                        Text("In Production")
                    } else {
                        Text("No Longer In Production")
                    }
                } else {
                    Text("No Longer In Production")
            }

                if detailServices.showDetail?.networks != nil {
                    if (detailServices.showDetail?.networks.count)! > 0 {
                    Text("Network: \(detailServices.showDetail!.networks[0].name)")
                    } else {
                        Text("Network Unavailable")
                    }
                } else {
                    Text("Network Unavailable")
                }
//

                if detailServices.showDetail?.vote_count != nil {
                    Text("Vote Count: \(detailServices.showDetail!.vote_count)")
                } else {
                    Text("N/A")
                }
                Text("Status: \(detailServices.showDetail?.status ?? "N/A")")
                Text("Overview: \(detailServices.showDetail?.overview ?? "N/A")")
            }
            
            Button(action: {
                let show = MyShow(context: self.managedObjectContext)
                show.name = self.name
                show.id = Int32(self.detailServices.showID)
                show.vote_average = self.detailServices.vote_average
                show.air_date = self.detailServices.showDetail?.next_episode_to_air?.air_date ?? "N/A"
                show.episode_number = Int32(self.detailServices.showDetail?.next_episode_to_air?.episode_number ?? 0)
                show.season_number = Int32(self.detailServices.showDetail?.next_episode_to_air?.season_number ?? 0)
                show.first_air_date = self.detailServices.showDetail?.first_air_date
                show.in_production = self.detailServices.showDetail?.in_production ?? false
                show.number_of_seasons = Int32(self.detailServices.showDetail?.number_of_seasons ?? 0)
                show.overview = self.detailServices.showDetail?.overview
                show.popularity = self.detailServices.showDetail?.popularity ?? 0
                show.poster_path = self.detailServices.showDetail?.poster_path
                show.status = self.detailServices.showDetail?.status
                show.vote_count = Int32(self.detailServices.showDetail?.vote_count ?? 0)
                show.image = self.detailServices.showImage.pngData()
                       // Handle operations with data here...
                
                //todo need to save the image too
                
                do {
                    try self.managedObjectContext.save()
                    //print("save successful")
                    //print("detailServices.showID \(self.detailServices.showID)")
                    //print("showID:\(show.id)")
                    //print(self.detailServices.showDetail)
                    //print("this is the show: \(show)")
                } catch {
                    "error saving managedObjectContext in detail view"
                }
            }) { Text("Insert example show")
            }

        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(detailServices: DetailServices(showID: 55555, poster_path: "jjj", vote_average: 0.0), name: "Name")
    }
}
