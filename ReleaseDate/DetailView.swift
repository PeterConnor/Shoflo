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
            Text("Detail View")
            Image(uiImage: detailServices.showImage)
                .resizable()
            Text(name)
            Text("detailServices.showID: \(detailServices.showID)")
            Text("Rating: \(detailServices.vote_average, specifier: "%.1f")")
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
