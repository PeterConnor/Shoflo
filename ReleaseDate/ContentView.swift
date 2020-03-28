//
//  ContentView.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/22/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var fetcher = Fetcher()
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
            }
            MyShowsView()
                .tabItem {
                Image(systemName: "heart")
                Text("Favorites")
            }
            DiscoverView()
                .tabItem {
                    Image(systemName: "lightbulb")
                    Text("Discover")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
