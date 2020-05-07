//
//  Notes.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/23/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

/*
 ***BUGS***
 -navigation link doesn't work if you go to detailview and back, unless u search first and then hit nav link and back. Might need to update.
 
 ***To Do***
 -need to put overview in...scroll view?
 -need to fix date format in detail view
 -I'm saving too much to core data because im not loading detail view from core data. i stopped saving the last few additions. =/
 -segmented controller looks bad if there are too many favorites
 -app crashes if you add a show to favs and then try to click last recommended show in discover view.
 -cant search by multiple words.
 -prevent dupes from saving to favs?
 -pretty sure the app crashes if there's no image and you try to save something to core data.
  -add sort to the lists, so no image availables go to bottom.
 -filter out results that dont have anything besides a name?
 -i dont think discover recommended works correctly after deleting something from favorites because myshows is already initialized with the core data, but not updated after the delete. the core data is update, but not myshows in discoverview. (i think) A good way to test is to have multiple shows in a row.
 -notifications. how are these going to look?
 Segmented Control with 3 options:
-need to run code in background for shows that have null next episode date.
 https://www.hackingwithswift.com/example-code/system/how-to-run-code-when-your-app-is-terminated
 -Need to remove list row and make it its own view?
 -simple animations
 -your rating, with ability to submit rating.
 -watched, to watch.

 Look at similar apps for ideas
 
 ***Ideas for Polish***
 
 ***QUESTIONS***
 -what's the difference between list and forEach? (can't manipulate each item in list?). DOES IMAGE WORK WITH FOREACH?
 -Why does navigationlink load detailview for each item in list?
 -difference between global async vs main async
 */
