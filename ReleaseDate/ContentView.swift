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
    @ObservedObject var connectivityChecker = ConnectivityChecker()

    var body: some View {
        ZStack{
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
            if connectivityChecker.disconnected == true {
                Button(action: {
                    self.connectivityChecker.disconnected = false
                }) {
                    Text("No Internet Connection")
                        .padding(10)
                        .background(Color.red)
                        .cornerRadius(10)
                        .foregroundColor(Color.white)
                    
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
