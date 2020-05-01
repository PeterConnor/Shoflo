//
//  SearchView.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/25/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var services = Services()
    
    var body: some View {
        NavigationView {
                VStack {
                TextField("Enter Show Name", text: $services.query, onCommit: services.load)
                    .padding(.leading, 20)
                List {
                    ForEach(Array(self.services.shows.enumerated()), id: \.1.id) { (index, show) in
                    HStack {
                        NavigationLink(destination: DetailView(detailServices: DetailServices(showID: show.id, poster_path: show.poster_path, vote_average: show.vote_average), name: show.name ?? "")) {
                            if self.services.shows.count == self.services.imageList.count && self.services.imageList.count > 0 {
                                Image(uiImage: self.services.imageList[index] ?? UIImage(named: "ImageNotAvailable")!)
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
            }
            .navigationBarTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
