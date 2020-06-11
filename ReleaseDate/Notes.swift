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
 
 //testing
 save a show with no air date & check notifications
 -done. saves correctl
 save a show with air date as ep 1 & check notifications
 -done. saves correctly and sets notifications
 save a show with air date as > ep 1 & check notification
 -done. this works. notifications arent set.
 check bgrefresh for all of these situations. might have to remove the show air date save
 ***Need to uncomment the air date trigger AND the core data save in detail view.
 -done. it works for ep 1 shows doesnt do anything for ep > 1 , which is expected.
 then i need to test if old air dates get wiped away and make sure the nil or N/A saves to core data. 
 
 ***To Do***
 
---in scenedidbecome active, i added nextAirDate.getCoreDataAndCheckNextAirDate(backgroundTrueForegroundFalse: false)
 i need to make true set the immediate notification, but I need false which is foreground to to a local notification or an alert. 
 //i dont think its good that im saving next air dates to core data. if the 1st ep of s3 gets saved, then the app will not trigger a notification for ep 1 of season 3. Need to look into this. the next air date saves in detail view and NextAirDate for BGRefresh. For this, i need to do something like if next air date < Date show.next air date = "N/A". I prob need to do that in the BG refresh and every time the app launches. Maybe add this to next air date class.
 -notifications for next air date work. Just need to make them 30 days out, 7 days out, 1 day out & clean up look
 -need to show alert if self.notificationManager.isAuthorized == false in detail view. need to disable it myself.
 -put each detail vertical stack in its own hstack with spacers on either side.
 -add sort to the lists, so no image availables go to bottom (should i filter those out altogether?).
 -do i need to add comments to info.plist?
 
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
 -add vibrate?
 -can i open the app from the lock screen with the notification?
 yes
 -what happens if i save a show with no next air date?
 it's fine
 -are delivered notifictions removed?
 yes
 -is only the first ep saved as next air date?
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
 -BGRefresh doesnt get triggered in low battery mode.
 
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
 
 
 Background Tasks
 e -l objc -- (void)[[BGTaskScheduler sharedScheduler] _simulateLaunchForTaskWithIdentifier:@"com.c0nman.ReleaseDate.fetch"]
 
 */
