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
    @EnvironmentObject var nextAirDate: NextAirDate
    
    //this is a hack to refresh the list. if user saves show and goes to discover view, the list is not updated, even though the new show is in the picker view.
    @State var needsRefresh = false

    
    //need to remove this. for testing notifications...
    var notificationManager = NotificationManager()
    
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
                    ZStack {
                        HStack {
                            if self.discoverServices.shows.count == self.discoverServices.imageList.count && self.discoverServices.imageList.count > 0 {
                                Image(uiImage: self.discoverServices.imageList[index] ?? UIImage(named: "imagenotavailable")!)
                                .resizable()
                                .cornerRadius(10)
                                .shadow(color: Color(.secondaryLabel), radius: 2)
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
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                            }.alert(isPresented: self.$nextAirDate.newAirDateAndEnteredForeground) {
                                Alert(title: Text("New Air Date Available"), message: Text("The first episode of a new season of \(self.nextAirDate.showForAlert) has been released! See Favorites for details."), dismissButton: .default(Text("Okay")))
                            }
                        }
                        NavigationLink(destination: DetailView(detailServices: DetailServices(showID: show.id, poster_path: show.poster_path, vote_average: show.vote_average), name: show.name ?? "")) {
                            EmptyView()
                        }
                    }
                }
                .frame(height: 120)
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(color: Color(.secondaryLabel), radius: 4, x: 0, y: 1)
            }.onAppear {
                print(self.notificationManager.checkNotificationsSettingsAuthorizationStatus())
                self.needsRefresh.toggle()
                UITableView.appearance().separatorStyle = .none
                //print("onappear")
                //print(self.myShows)
                for i in self.myShows {
                    //print("air date \(i.air_date)")
                }
                
                self.notificationManager.getPending()
                for i in self.myShows {
                    //print("saved air date")
                    //print(i.air_date)
                }
                
                if self.myShows.count > 2 {
                    self.discoverServices.myShowIndex = 1
                }
            }
        }.navigationBarTitle("Discover")
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
