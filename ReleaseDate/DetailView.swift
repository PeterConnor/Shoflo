//
//  DetailView.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/31/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var detailServices: DetailServices
    var name: String
    
    
    var body: some View {
        VStack {
            Text("Detail View")
            Image(uiImage: detailServices.showImage)
                .resizable()
            Text(name)
            Text("\(detailServices.showID)")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(detailServices: DetailServices(showID: 55555, poster_path: "jjj"), name: "Name")
    }
}
