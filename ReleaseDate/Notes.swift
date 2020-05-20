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
 -need to show alert if self.notificationManager.isAuthorized == false in detail view
 -put each detail vertical stack in its own hstack with spacers on either side.
 -add sort to the lists, so no image availables go to bottom (should i filter those out altogether?).
 -notifications. how are these going to look?
 -need to be able to delete notifications.
 https://www.hackingwithswift.com/example-code/system/how-to-set-local-alerts-using-unnotificationcenter
 -need to run code in background for shows that have null next episode date.
 https://www.hackingwithswift.com/example-code/system/how-to-run-code-when-your-app-is-terminated
 
 ***Post MVP***
 -maybe just do recommended based off all shows, and filter out dupes.
 -watched, to watch.
 -your rating, with ability to submit rating.
 -simple animations
 -Look at similar apps for ideas
 -Polish
 -more pages in results
 -add other ways to sort
 -custom alerts / on-off
 -to watch list
 
 ***QUESTIONS***
 -what's the difference between list and forEach? (can't manipulate each item in list?). DOES IMAGE WORK WITH FOREACH?
 -Why does navigationlink load detailview for each item in list?
 -difference between global async vs main async
 */
