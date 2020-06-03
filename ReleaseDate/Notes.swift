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
 -test //tezt this *** in detailcview to make sure notifications are only scheduled for ep 1 of season.
 -it looks like immediate notification and 3 notifications work. do 1 final round of tests.
 -next step - look up ******************* in NextAirDate
 -remember that the next air date isnt saving to core data, so you can text the background fetch. you commented that out in detailview, so no next air dates save.
 -notifications for next air date work. Just need to make them 30 days out, 7 days out, 1 day out & clean up look
 -need to show alert if self.notificationManager.isAuthorized == false in detail view. need to disable it myself.
 -put each detail vertical stack in its own hstack with spacers on either side.
 -add sort to the lists, so no image availables go to bottom (should i filter those out altogether?).
 -do i need to add comments to info.plist?
 -need to run code in background for shows that have null next episode date.
 https://www.hackingwithswift.com/example-code/system/how-to-run-code-when-your-app-is-terminated
 
 -do notifications get properly set once the show is saved?
 yes
 -do notifications get deleted once the favorite show is deleted?
 yes
 -do triggered notifications get deleted?
 yes
 -not only triggered, but past/old notifications?
 yes
 -do notifications run when i close the app?
 yes
 -do they run when the lock screen ISNT on?
 yes. they DO NOT fire when the app is running
 -add vibrate
 -can i open the app from the lock screen with the notification?
 yes
 -what happens if i save a show with no next air date?
 it's fine
 -are delivered notifictions removed?
 yes
 
 ***Post MVP***
  -since bgrefresh doesnt run when backgrund refresh is disabled, i should run the fetch request whenever the app gets launched.
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

/*
load myshows into app delegate OR can i create a singleton that checks for nil next air date AND checks if there's a new one.
cycle through. if show next air date == nil, then check to see if there's a new air date. if so, replace nil with value.
 
Need to add the 3 notifications AND trigger an immediate one.
 
 singleton class check next air date.
 
 I can test by removing the next air date save from the core data save in detail view. then check shows that do have a next air date. that field will be blank.
 
 e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.c0nman.ReleaseDate.fetch"]
 
 */
