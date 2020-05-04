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
 -I'm saving too much to core data because im not loading detail view from core data =/
 -add genres, last episode to air to detail?, original_language?, type?  .
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
 -For recommendations, it currently checks against favorited shows. Should user be able to search for a show, and then have results pop up based on that show?
-need to run code in background for shows that have null next episode date.
 https://www.hackingwithswift.com/example-code/system/how-to-run-code-when-your-app-is-terminated
 -Need to remove list row and make it its own view?
 -polish
 https://www.youtube.com/watch?v=MJP60XnN4us <- code with chris
 https://www.hackingwithswift.com/quick-start/swiftui/polishing-designs-with-fonts-and-colors
 -simple animations

 Look at similar apps for ideas
 
 ***Ideas for Polish***

 SS saved on desktop. gradients
 
 https://www.google.com/imgres?imgurl=https%3A%2F%2Fres.cloudinary.com%2Fliquidcoder%2Fimage%2Fupload%2Fv1569392476%2Fswiftui-weatherapp%2Fd1g8o9ldwntqrcsnqsic.png&imgrefurl=https%3A%2F%2Fliquidcoder.com%2Fweatherui-in-swiftui%2F&tbnid=cBNsII0A_3NvQM&vet=12ahUKEwiLv6Cg0YjpAhUFl-AKHYCwCwQQMygqegQIARBZ..i&docid=ndJ8zFiByIhwFM&w=780&h=1600&q=swiftui%20detail%20view&client=safari&ved=2ahUKEwiLv6Cg0YjpAhUFl-AKHYCwCwQQMygqegQIARBZ
 
 https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.iosapptemplates.com%2Fwp-content%2Fuploads%2F2019%2F11%2FHow-To-Build-a-Login-Screen-1024x683.png&imgrefurl=https%3A%2F%2Fwww.iosapptemplates.com%2Fblog%2Fswiftui%2Flogin-screen-swiftui&tbnid=ZYubBT_hiZhJ9M&vet=12ahUKEwiLv6Cg0YjpAhUFl-AKHYCwCwQQMyhAegUIARCIAQ..i&docid=r36WOSqiSLVaUM&w=1024&h=683&q=swiftui%20detail%20view&client=safari&ved=2ahUKEwiLv6Cg0YjpAhUFl-AKHYCwCwQQMyhAegUIARCIAQ


 ***QUESTIONS***
 -what's the difference between list and forEach? (can't manipulate each item in list?). DOES IMAGE WORK WITH FOREACH?
 -Why does navigationlink load detailview for each item in list?
 -difference between global async vs main async
 */
