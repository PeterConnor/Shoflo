//
//  Notes.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/23/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

/*
 ***BUGS***
 -navigation link does work if you go to detailview and back, unless u search first and then hit nav link and back. Might need to update.
 -Try Image with ForEach
 
 ***To Do***
 -notifications. how are these going to look?
 -Discover - for recommended, Need to pass through id of favorited shows from core data list.
 -delete network manager file?
 Segmented Control with 3 options:
 1. Get Recommendations returns good results based on ids of shows. Could check against saved shows or user could enter show.
 2. Get Popular - Get a list of the current popular TV shows on TMDb. This list updates daily.
 3. Get top rated? Results are a bit weird.
-need to run code in background for shows that have null next episode date.
 https://www.hackingwithswift.com/example-code/system/how-to-run-code-when-your-app-is-terminated
 -

 
 (Get Similar shows return bad results.)
 
    
 -Need to remove list row and make it its own view
 -Add image to searchview results, eventually =/
 
 ***IDE***
 Look at similar apps for ideas

 
***TMBD LINKS***
 Search TV Shows
 https://developers.themoviedb.org/3/search/search-tv-shows
 Get TV Details
 https://developers.themoviedb.org/3/tv/get-tv-details
 Now Playing Movies?
    URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
 
 ***QUESTIONS***
 -what's the difference between list and forEach? (can't manipulate each item in list?). DOES IMAGE WORK WITH FOREACH?
 Why does navigationlink load detailview for each item in list?
 
 */
