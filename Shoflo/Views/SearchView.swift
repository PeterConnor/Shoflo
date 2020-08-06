//
//  SearchView.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/25/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// refactor - done
// previews - fixed

import SwiftUI

struct SearchView: View {
    @ObservedObject var services = Services()
    @EnvironmentObject var nextAirDate: NextAirDate
    
    var body: some View {
        NavigationView {
                VStack {
                    TextField("Enter Show Name", text: $services.query, onCommit: services.load)
                        .padding(.leading, 20)
                List {
                    ForEach(Array(self.services.shows.enumerated()), id: \.1.id) { (index, show) in
                        ZStack {
                            HStack {
                                if self.services.shows.count == self.services.imageList.count && self.services.imageList.count > 0 {
                                    Image(uiImage: self.services.imageList[index] ?? UIImage(named: "imagenotavailable")!)
                                        .resizable()
                                        .cornerRadius(10)
                                        .shadow(color: Color(.secondaryLabel), radius: 2)
                                        .aspectRatio(contentMode: .fit)
                                        .padding(5)
                                        .frame(width: 80, height: 120)
                                }
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(show.name ?? "")
                                            .fontWeight(.black)
                                            .foregroundColor(.primary)
                                        Text("⭐️ \(show.vote_average, specifier: "%.1f")")
                                            .padding(.trailing, 5)
                                    }
                                    .padding(.top, 5)
                                    
                                    HStack {
                                        Text(show.overview ?? "")
                                        Spacer()
                                        VStack {
                                            Spacer()
                                        }
                                    }
  
                                }
                                .alert(isPresented: self.$nextAirDate.newAirDateAndEnteredForeground) {
                                
                                Alert(title: Text("New Air Date Available"), message: Text("The first episode of a new season of \(self.nextAirDate.showForAlert) has been released! See Favorites for details."), dismissButton: .default(Text("Okay")))
                                }
                            }
                            NavigationLink(destination: DetailView(detailServices: DetailServices(showID: show.id, poster_path: show.poster_path, vote_average: show.vote_average), name: show.name ?? "")) {
                                EmptyView()
                            }
                        }
                    }
                    .frame(height: 120)
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                    .shadow(color: Color(.secondaryLabel), radius: 4, x: 0, y: 1)
                }
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
            }
            .navigationBarTitle("Search")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
