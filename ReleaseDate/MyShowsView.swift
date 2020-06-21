//
//  MyShowsView.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/25/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

import SwiftUI

struct MyShowsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: MyShow.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \MyShow.name, ascending: true)
        ]
    )
    
    var myShows: FetchedResults<MyShow>
    @EnvironmentObject var nextAirDate: NextAirDate

    
    var notificationManager = NotificationManager()
    
    func getImageFromData(show: MyShow) -> UIImage  {
        //this is just a placeholder
        var finalImage = (UIImage(named: "imagenotavailable"))
        if let data = show.image {
            if let image = UIImage(data: data as Data) {
                finalImage = image
                }
            }
            return finalImage!
        }
    
    func removeMyShow(at offsets: IndexSet) {
        for index in offsets {
            let myShow = myShows[index]
            print(myShow.id)
            notificationManager.center.removeAllDeliveredNotifications()
            print("before notification deletion")
            notificationManager.getPending()
            self.notificationManager.center.removePendingNotificationRequests(withIdentifiers: ["\(myShow.id)", "\(myShow.id)" + "2", "\(myShow.id)" + "3"])
            print("after notification deletion")
            notificationManager.getPending() //this is a print statement. need to remove these sneaky ones before ship
            
            managedObjectContext.delete(myShow)
            do {
                try self.managedObjectContext.save()
                //print("save successful")
                //print("myShows: \(myShows)")
            } catch {
                "error saving managedObjectContext in detail view"
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(myShows, id: \.self) { (show: MyShow) in
                    ZStack {
                        HStack {
                                Image(uiImage: self.getImageFromData(show: show))
                                    .resizable()
                                    .cornerRadius(10)
                                    .shadow(color: Color(.secondaryLabel), radius: 2)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(5)
                                    .frame(width: 80, height: 120)
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(show.name ?? "")
                                            .fontWeight(.black)
                                        Text("⭐️ \(show.vote_average, specifier: "%.1f")")
                                    }
                                    Text(show.overview ?? "")
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                                        .alert(isPresented: self.$nextAirDate.newAirDateAndEnteredForeground) {
                                    Alert(title: Text("Check"), message: Text("Next Air Date"), dismissButton: .default(Text("Okay")))
                                    }
                                }
                            
                        }
                        .frame(height: 120)
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(color: Color(.secondaryLabel), radius: 4, x: 0, y: 1)
                        NavigationLink(destination: DetailView(detailServices: DetailServices(showID: Int(show.id), poster_path: show.poster_path, vote_average: show.vote_average), name: show.name ?? "")) {
                            EmptyView()
                        }
                    }.onAppear {
                    UITableView.appearance().separatorStyle = .none
                    }
                }.onDelete(perform: removeMyShow)
            }.navigationBarTitle("Favorites")
        }.navigationViewStyle(StackNavigationViewStyle())
        //You can delete with swipe, but maybe add
        //.navigationBarItems(trailing: EditButton())
    }
}

struct MyShowsView_Previews: PreviewProvider {
    static var previews: some View {
        MyShowsView()
    }
}
