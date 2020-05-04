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
    @Environment(\.managedObjectContext) var managedObjectContext

    var name: String
    
    func getRunTime(list: [Int]) -> Int {
        var count = 0
        for i in list {
            count += i
        }
        return count / list.count
    }
    
    var body: some View {
        VStack {
            Group {
                VStack {
                    Text(name)
                    .fontWeight(.black)
                    .font(.largeTitle)
                }
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .black, radius: 5)
                
                Image(uiImage: detailServices.showImage)
                    .resizable()
                    .frame(width: 200, height: 300)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 5)
                    .padding(20)
                Group {
                    Text("⭐️ \(detailServices.vote_average, specifier: "%.1f")") + Text(" (\(detailServices.showDetail?.vote_count ?? 0) votes)").foregroundColor(Color.gray)
                    
                    if detailServices.showDetail?.first_air_date != nil {
                        Text("First Air Date: ").fontWeight(.black) + Text("\(detailServices.showDetail!.first_air_date)")
                    } else {
                        Text("N/A")
                    }
                }
                
                
                Group{
                    if detailServices.showDetail?.origin_country != nil {
                        if detailServices.showDetail!.origin_country.count > 0 {
                         Text("Origin Country: ").fontWeight(.black) + Text("\(detailServices.showDetail!.origin_country[0])")
                        } else {
                            Text("Origin Country: ").fontWeight(.black) + Text("N/A").foregroundColor(Color.gray)
                        }
                    } else {
                        Text("Origin Country: ").fontWeight(.black) + Text("N/A").foregroundColor(Color.gray)
                    }
                }
               
                
                Text("Next Episode Air Date: \(detailServices.showDetail?.next_episode_to_air?.air_date ?? "N/A")")
                
                if detailServices.showDetail?.next_episode_to_air?.episode_number != nil {
                   Text("Next Episode Number: \(detailServices.showDetail!.next_episode_to_air!.episode_number)")
                } else {
                    Text("N/A")
                }
                
                if detailServices.showDetail?.next_episode_to_air?.season_number != nil {
                    Text("Next Season Number: \(detailServices.showDetail!.next_episode_to_air!.season_number)")
                } else {
                    Text("N/A")
                }
                Group {
                    if detailServices.showDetail?.number_of_seasons != nil {
                        Text("Seasons: ").fontWeight(.black) + Text("\(detailServices.showDetail!.number_of_seasons)")
                     } else {
                        Text("Seasons: ").fontWeight(.black) + Text("N/A").foregroundColor(Color.gray)
                     }
                    if detailServices.showDetail?.number_of_episodes != nil {
                         Text("Episodes: ").fontWeight(.black) + Text("\(detailServices.showDetail!.number_of_episodes)")
                     } else {
                         Text("Episodes: ").fontWeight(.black) + Text("N/A").foregroundColor(Color.gray)
                     }
                    
                    if detailServices.showDetail?.episode_run_time != nil {
                        if detailServices.showDetail!.episode_run_time.count > 0 {
                            Text("Run Time: ").fontWeight(.black) + Text("\(getRunTime(list: detailServices.showDetail!.episode_run_time))")
                        } else {
                            Text("Run Time: ").fontWeight(.black) + Text("N/A").foregroundColor(Color.gray)

                        }
                    } else {
                        Text("Run Time: ").fontWeight(.black) + Text("N/A").foregroundColor(Color.gray)
                    }
                      
                    
                }
                //I probably need to combine season number and ep number for next episode?
                
                
                if detailServices.showDetail?.popularity != nil && detailServices.showDetail?.vote_count != nil {
                    if detailServices.showDetail!.popularity > 49.0 && detailServices.showDetail!.vote_count > 250 {
                        Text("Popularity: ").fontWeight(.black) + Text("High")
                    } else if detailServices.showDetail!.popularity > 10.0 {
                        Text("Popularity: ").fontWeight(.black) + Text("Medium")
                    } else {
                        Text("Popularity: ").fontWeight(.black) + Text("Low")
                    }
                } else {
                    Text("Popularity: ").fontWeight(.black) + Text("Low")
                }
                if detailServices.showDetail?.status != nil {
                    Text("Status: ").fontWeight(.black) + Text("\(detailServices.showDetail!.status)")
                } else {
                    Text("Status: ").fontWeight(.black) + Text("N/A").foregroundColor(Color.gray)
                }
            }
            
            Group {
                if detailServices.showDetail?.in_production != nil {
                    if detailServices.showDetail?.in_production == true {
                        Text("In Production")
                    } else {
                        Text("No Longer In Production")
                    }
                } else {
                    Text("No Longer In Production")
            }

                if detailServices.showDetail?.networks != nil {
                    if (detailServices.showDetail?.networks.count)! > 0 {
                    Text("Network: \(detailServices.showDetail!.networks[0].name)")
                    } else {
                        Text("Network Unavailable")
                    }
                } else {
                    Text("Network Unavailable")
                }

                Text("Status: \(detailServices.showDetail?.status ?? "N/A")")
                Text("Overview: \(detailServices.showDetail?.overview ?? "N/A")")
            }
            
            Button(action: {
                let show = MyShow(context: self.managedObjectContext)
                show.name = self.name
                show.id = Int32(self.detailServices.showID)
                show.vote_average = self.detailServices.vote_average
                show.air_date = self.detailServices.showDetail?.next_episode_to_air?.air_date ?? "N/A"
                show.episode_number = Int32(self.detailServices.showDetail?.next_episode_to_air?.episode_number ?? 0)
                show.season_number = Int32(self.detailServices.showDetail?.next_episode_to_air?.season_number ?? 0)
                show.first_air_date = self.detailServices.showDetail?.first_air_date
                show.in_production = self.detailServices.showDetail?.in_production ?? false
                show.number_of_seasons = Int32(self.detailServices.showDetail?.number_of_seasons ?? 0)
                show.number_of_episodes = Int32(self.detailServices.showDetail?.number_of_episodes ?? 0)
                show.overview = self.detailServices.showDetail?.overview
                show.popularity = self.detailServices.showDetail?.popularity ?? 0
                show.poster_path = self.detailServices.showDetail?.poster_path
                show.status = self.detailServices.showDetail?.status
                show.vote_count = Int32(self.detailServices.showDetail?.vote_count ?? 0)
                
                if self.detailServices.showDetail?.episode_run_time != nil {
                    if self.detailServices.showDetail!.episode_run_time.count > 0 {
                        show.episode_run_time = Int32(self.getRunTime(list: self.detailServices.showDetail!.episode_run_time))
                    } else {
                        show.episode_run_time = 0
                    }
                } else {
                    show.episode_run_time = 0
                }
                
                show.episode_run_time = Int32(self.getRunTime(list: self.detailServices.showDetail?.episode_run_time ?? [0]))
                show.image = self.detailServices.showImage.pngData()
                do {
                    try self.managedObjectContext.save()
                } catch {
                    "error saving managedObjectContext in detail view"
                }
            }) { Text("Insert example show")
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(detailServices: DetailServices(showID: 55555, poster_path: "jjj", vote_average: 0.0), name: "Name")
    }
}
