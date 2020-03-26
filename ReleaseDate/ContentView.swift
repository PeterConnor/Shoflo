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
        VStack {
            List(fetcher.shows) { show in
                VStack (alignment: .leading) {
                    Text(show.name)
                        .font(.system(size: 11))
                        .foregroundColor(Color.gray)
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
