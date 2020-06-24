//
//  Notes.swift
//  ReleaseDate
//
//  Created by Pete Connor on 3/23/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

/*

***To Do***
 -moved alert on searchview, need to check entered foreground alert 
 -fix dark mode in detail view. check other views
 -notifications for next air date work. Just need to make them 30 days out, 7 days out, 1 day out & clean up look
 -need to show alert if self.notificationManager.isAuthorized == false in detail view. need to disable it myself to test.
 -put each detail vertical stack in its own hstack with spacers on either side.
 -do i need to add comments to info.plist?
 

 
 ***Post MVP***
  -since bgrefresh doesnt run when backgrund refresh is disabled, i should run the fetch request whenever the app gets launched.
 -maybe just do recommended based off all shows, and filter out dupes.
 -watched, to watch.
 -your rating, with ability to submit rating.
 -simple animations
 improve the picker on discover. Maybe put 'Favorite Shows' on left
 -Look at similar apps for ideas! (There are a lot out there)
 -Polish
 -add sort to the lists, so no image availables go to bottom (should i filter those out altogether?).
 -more pages in results
 -add other ways to sort
 -news updates
 have related shows in detail page, rather than needing user to save show.
 -custom alerts / on-off
 -to watch list
 -BGRefresh doesnt get triggered in low battery mode.
 -sort favorites by active
 
 ***QUESTIONS***
 -what's the difference between list and forEach? (can't manipulate each item in list?). DOES IMAGE WORK WITH FOREACH?
 -Why does navigationlink load detailview for each item in list?
 -difference between global async vs main async
 */

/*
 
 
 Background Tasks
 e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.c0nman.ReleaseDate.fetch"]
 
 */
