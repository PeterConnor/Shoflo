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
            managedObjectContext.delete(myShow)
            do {
                try self.managedObjectContext.save()
                print("save successful")
                print("myShows: \(myShows)")
            } catch {
                "error saving managedObjectContext in detail view"
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(myShows, id: \.self) { (show: MyShow) in
                    VStack {
                        NavigationLink(destination: DetailView(detailServices: DetailServices(showID: Int(show.id), poster_path: show.poster_path, vote_average: show.vote_average), name: show.name ?? "")) {
                            Image(uiImage: self.getImageFromData(show: show))
                                .resizable()
                                .cornerRadius(10)
                                .shadow(color: .black, radius: 2)
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
                            }
                        }
                    }
                    .frame(height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 2)
                }.onDelete(perform: removeMyShow)
            }.navigationBarTitle("Favorites")
        }
        //You can delete with swipe, but maybe add
        //.navigationBarItems(trailing: EditButton())
    }
}

struct MyShowsView_Previews: PreviewProvider {
    static var previews: some View {
        MyShowsView()
    }
}
