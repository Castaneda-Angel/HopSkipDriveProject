# HopSkipDrive Project

Third party libraries used:
-SnapKit

Notes:

This project was overall really fun! I know that you all use SnapKit so I decided to try my hand at it. This was my first time using it but I think I got a pretty good hold of it already. I personally think that SnapKit is super useful and clean and I'm glad I tried it for this project! I feel like laying out views in a storyboard is easy to visualize but SnapKit feels really powerful as well. I also made sure to get rid of the SnapKit layout warnings so I'm sure that my screens will hold up.

The Project Overview said that the project should look like the images provided so I was as detailed as I could be. I think I was spot on with the dark blue app color and the light blue accent color. I bolded the texts that look bolded, used attributed strings to add style to parts of the string (Like in the My Rides screen, each ride has an "est. $amount" and the "est" is smaller than the amount.), and I added a custom back button to match.

I'd say the most difficult part overall was figuring out how to separate the rides into different sections. I personally did it by retrieving all of the rides from the API. Next, I create a dictionary with strings as the key and an array of rides for the values. To populate the dictionary, I loop through all of the rides and look for the dates, turn those dates into M/dd/yyyy strings (I cut off the time because there would only be 1 ride to match for each date), and use that as the dictionary key. If the key already exists in the dictionary then I just append the ride under that key, if it doesn't exist then I just create a new key. After all of that is complete, I start looping through all of the keys in the dictionary and format data for the section headers. Dictionaries don't guarentee order, though, so I put each date/rides in a new Section class that holds data for each section (like the time range for the section, and the estimated total earnings). Once all section objects are in an array, I sort them by date to make sure the earliest dates are first!

Improvements I Would Make:

1. More reusable views. I definitely could've made my views a bit more reusable and I think it would be a massive improvement.

2. Use a collection view instead of a table view for the My Rides screen. I realized too late that table views don't have a clean way of adding spacing between cells, while collection views do. I made it work but the workable space within the cells is smaller than usual because of it.

3. Write more tests. I was able to write unit tests for my utility functions, but more tests would for sure be an improvement.

4. Use more labels instead of attributed strings. I don't know if this would be a big improvement, but it would definitely make the code cleaner. I used attributed strings for styling a part of a string, but that added about 6 lines of code at times to style 2 parts of a string. Using a different label for each part of the string would allow the styling to be set within its own label.

5. Change the font of the app. I couldn't quite get the font the same as the pictures so I just used the system font. It's a small improvement but it would make my version of the app look cleaner overall!

6. Support dark mode. I noticed that when the user is in dark mode for their device, it changes some colors but not others and it's not a good experience. I ended up changing it so that the appearance is forced to the "Light" appearance, but giving dark mode full support would be great.

7. Use scalable font sizes. On smaller screen sizes, the font stays the same which makes the app look a little off (big text, small device). It looks great on regular/large screen sizes but the goal is to make it look great on all sizes. Adjusting the font size with the width of the screen would fix this issue and make the overall app experience fantastic!
