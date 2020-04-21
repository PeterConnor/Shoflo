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
 
 ***To Do***
 -add image to myshows/favorites and discover
 need to put everything in the getImage async to avoid UI lag?
 
 -i dont think discover recommended works correctly after deleting something from favorites because myshows is already initialized with the core data, but not updated after the delete. the core data is update, but not myshows in discoverview. (i think) A good way to test is to have multiple shows in a row.
 -notifications. how are these going to look?
 -delete network manager file?
 Segmented Control with 3 options:
 -For recommendations, it currently checks against favorited shows. Should user be able to search for a show, and then have results pop up based on that show?
-need to run code in background for shows that have null next episode date.
 https://www.hackingwithswift.com/example-code/system/how-to-run-code-when-your-app-is-terminated
 -Need to remove list row and make it its own view?
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
 -difference between global async vs main async
 */
