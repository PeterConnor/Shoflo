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
    
    func removeMyShow(at offsets: IndexSet) {
        for index in offsets {
            let myShow = myShows[index]
            managedObjectContext.delete(myShow)
            do {
                try self.managedObjectContext.save()
                print("save successful")
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
                        NavigationLink(destination: DetailView(detailServices: DetailServices(showID: Int(show.id), poster_path: "TestPosterPath", vote_average: 20), name: show.name ?? "")) {
                        Text(show.name ?? "")
                        }
                    }
                }.onDelete(perform: removeMyShow)
            }
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
