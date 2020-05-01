//
//  DiscoverView.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/28/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

import SwiftUI

struct DiscoverView: View {
    @ObservedObject var discoverServices = DiscoverServices()
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: MyShow.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \MyShow.name, ascending: true)
        ]
    )
    
    var myShows: FetchedResults<MyShow>
    
    var body: some View {
        NavigationView {
            VStack {
            Picker(selection: $discoverServices.discoverNumber, label: Text("Discover Shows")) {
                   Text("Recommended").tag(0)
                   Text("Popular").tag(1)
                   Text("Top Rated").tag(2)
               }.pickerStyle(SegmentedPickerStyle())
            Text("Value: \(discoverServices.discoverNumber)")
            if discoverServices.discoverNumber == 0 {
                Picker(selection: $discoverServices.myShowIndex, label: Text("Select Show")) {
                    ForEach(0..<myShows.count) { i in
                        Text("\(self.myShows[i].name!)")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            List {
                ForEach(Array(self.discoverServices.shows.enumerated()), id: \.1.id) { (index, show) in
                VStack (alignment: .leading) {
                    NavigationLink(destination: DetailView(detailServices: DetailServices(showID: show.id, poster_path: show.poster_path, vote_average: show.vote_average), name: show.name ?? "")) {
                        if self.discoverServices.shows.count == self.discoverServices.imageList.count && self.discoverServices.imageList.count > 0 {
                            Image(uiImage: self.discoverServices.imageList[index] ?? UIImage(systemName: "xmark.square")!)
                            .resizable()
                        }
                        Text(show.name ?? "")
                        Text(show.overview ?? "")
                        Text("Rating: \(show.vote_average, specifier: "%.1f")")
                    
                        }
                    }
                }
            }
        }.navigationBarTitle("Discover")
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
