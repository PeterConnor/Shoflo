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
       VStack {
        Picker(selection: $discoverServices.discoverNumber, label: Text("Discover Shows")) {
               Text("Recommended").tag(0)
               Text("Popular").tag(1)
               Text("Top Rated").tag(2)
           }.pickerStyle(SegmentedPickerStyle())
        Text("Value: \(discoverServices.discoverNumber)")
        if discoverServices.discoverNumber == 0 {
            Picker(selection: $discoverServices.showID, label: Text("Select Show")) {
                ForEach(0..<myShows.count) {
                    Text("\(self.myShows[$0].id)" ?? "No Favorites")
                }
            }.pickerStyle(WheelPickerStyle())
       }
    }
}
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
