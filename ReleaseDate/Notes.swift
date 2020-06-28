//
//  Notes.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/23/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

/*

 ***To Do***
 -Initial instructions / wording when the screens are blank
 -need to fix alert wording too.
 -need to show alert if self.notificationManager.isAuthorized == false in detail view. need to disable it myself to test.
 -do i need to add comments to info.plist?
 
 ***Post MVP***
 -maybe just do recommended based off all shows, and filter out dupes.
 -watched, to watch.
 -your rating, with ability to submit rating.
 -simple animations
 -improve the picker on discover. Maybe put 'Favorite Shows' on left
 -Look at similar apps for ideas! (There are a lot out there)
 -Polish ( neumorphism)
 -make font bigger, especially in detail view
 -add sort to the lists, so no image availables go to bottom (should i filter those out altogether?).
 -more pages in results
 -add other ways to sort
 -news updates
 have related shows in detail page, rather than needing user to save show.
 -custom alerts / on-off
 -to watch list
 -BGRefresh doesnt get triggered in low battery mode.
 -sort favorites by active
 -if there are 2 new air dates when the app comes into foreground, only 1 alert is shown. not a big deal, but not ideal.

 
 ***QUESTIONS***
 -what's the difference between list and forEach? (can't manipulate each item in list?). DOES IMAGE WORK WITH FOREACH?
 -Why does navigationlink load detailview for each item in list?
 -difference between global async vs main async
 */

/*
 
 
 Background Tasks
 e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.c0nman.ReleaseDate.fetch"]
 
 */
