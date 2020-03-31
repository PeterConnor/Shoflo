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
        VStack {
            TextField("", text: $services.query, onCommit: services.load)
            List(services.shows) { show in
                VStack (alignment: .leading) {
                    Text(show.name ?? "")
                        .font(.system(size: 11))
                        .foregroundColor(Color.gray)
                    Image(uiImage: self.services.showImage!)
                    }
                }
            }

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
