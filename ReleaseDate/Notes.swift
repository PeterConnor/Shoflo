//
//  Notes.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/23/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

/*
 ***BUGS***
 -navigation link does work if you go to detailview and back, unless u search first and then hit nav link and back.
 
 ***To Do***
 -Need to remove list row and make it its own view
 -Add ratings and other relevant properties to datasearch, and then to searchview, and ultimately to detail view.
 -Allow user to save detailview 
 -Add image to searchview results?
 
 ***APP FLOW / IDEAS ***
 Search -> DetailView -> Add to ListView and set notifications
 ListView -> DetailView -> set/edit notifications
 Discover, based on user's saved shows
    Most Popular TV Shows / Highest Rated
 Sort by soonest release date?
 Look at similar apps for ideas
 Now Playing Movies?
    URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
 
***TMBD LINKS***
 Search TV Shows
 https://developers.themoviedb.org/3/search/search-tv-shows
 Get TV Details
 https://developers.themoviedb.org/3/tv/get-tv-details
 */
