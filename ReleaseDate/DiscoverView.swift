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
            if discoverServices.discoverNumber == 0 {
                VStack {
                    Picker(selection: $discoverServices.myShowIndex, label: Text("Select Show")) {
                            ForEach(0..<myShows.count) { i in
                                Text("\(self.myShows[i].name!)")
                        }
                    }.pickerStyle(WheelPickerStyle())
                        .labelsHidden()
                    .frame(height: 60)
                    .clipped()
                }
            }
            List {
                ForEach(Array(self.discoverServices.shows.enumerated()), id: \.1.id) { (index, show) in
                VStack (alignment: .leading) {
                    NavigationLink(destination: DetailView(detailServices: DetailServices(showID: show.id, poster_path: show.poster_path, vote_average: show.vote_average), name: show.name ?? "")) {
                        if self.discoverServices.shows.count == self.discoverServices.imageList.count && self.discoverServices.imageList.count > 0 {
                            Image(uiImage: self.discoverServices.imageList[index] ?? UIImage(named: "imagenotavailable")!)
                            .resizable()
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 2)
                            .aspectRatio(contentMode: .fit)
                            .padding(5)
                            .frame(width: 80, height: 120)
                        }
                        VStack(alignment: .leading) {
                            HStack {
                                Text(show.name ?? "")
                                    .fontWeight(.black)
                                Text("⭐️ \(show.vote_average, specifier: "%.1f")")
                            }
                            Text(show.overview ?? "")
                        }
                    
                        }
                    }
                }
                .frame(height: 120)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black, radius: 2)
            }
        }.navigationBarTitle("Discover")
        }.onAppear {
            print("this did appear")
            for i in self.myShows {
                print(i.air_date)
            }
            //need to remove this
            //let x = NextAirDate()
            //x.getCoreDataAndCheckNextAirDate()
            //to here
            
            if self.myShows.count > 2 {
                self.discoverServices.myShowIndex = 1
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
