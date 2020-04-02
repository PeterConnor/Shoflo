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
                TextField("", text: $services.query, onCommit: services.load)
                List(services.shows) { show in
                    VStack (alignment: .leading) {
                        NavigationLink(destination: DetailView(name: show.name ?? "")) {
                        Text(show.name ?? "")
                            Text("\(show.vote_average)")
                            Text(show.overview ?? "")
                            
                        //Image(uiImage: self.services.showImage!)
                        }
                    }
                }
            }
            .navigationBarTitle("Search Shows")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
