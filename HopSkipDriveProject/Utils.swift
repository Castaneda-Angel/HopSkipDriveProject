//
//  Utils.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/26/21.
//

/*
 Utility functions that help throughout the app
*/

import Foundation
import UIKit

/*
 From string to date
 -Can specify a format but will default to the date format from the JSON data.
*/
func stringToDate(dateString: String, format: String = "yyyy-MM-dd'T'HH:mm:ss'Z'") -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.dateFormat = format
    
    if let date = dateFormatter.date(from: dateString) {
        return date
    }
    else{
        return nil
    }
}

/*
 From date to string
 -Always specify the format needed
*/
func dateToString(date: Date, format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.dateFormat = format
    
    return dateFormatter.string(from: date)
}

/*
 Turn time (hours and minutes) to an easily comparable int
*/
func timeToInt(date: Date) -> Int {
    return 60 * Calendar.current.component(.hour, from: date) + Calendar.current.component(.minute, from: date)
}

/*
 Takes start and end dates and turns their times into a range.
 -Also gets rid of "AM/PM" and simplifies them to "a/p"
*/
func constructTimeRangeString(from startDate: Date, to endDate: Date, isSmallText: Bool, isForHeader: Bool) -> NSMutableAttributedString {
    var formattedStartTime = dateToString(date: startDate, format: "h:mm a")
    var formattedEndTime = dateToString(date: endDate, format: "h:mm a")
    
    formattedStartTime = formattedStartTime.replacingOccurrences(of: " AM", with: "a")
    formattedStartTime = formattedStartTime.replacingOccurrences(of: " PM", with: "p")
    formattedEndTime = formattedEndTime.replacingOccurrences(of: " AM", with: "a")
    formattedEndTime = formattedEndTime.replacingOccurrences(of: " PM", with: "p")
    
    let startTimeAttrs = [NSAttributedString.Key.font : isSmallText == true ? UIFont.boldSystemFont(ofSize: 13) : UIFont.boldSystemFont(ofSize: 16)]
    
    let fullTimeRangeText = NSMutableAttributedString(string: "\(isForHeader == true ? " • " : "")\(formattedStartTime)", attributes: startTimeAttrs)
    
    let endTimeAttrs = [NSAttributedString.Key.font : isSmallText == true ? UIFont.systemFont(ofSize: 13) : UIFont.systemFont(ofSize: 16)]
    
    let endTimeAttrString = NSMutableAttributedString(string: " - \(formattedEndTime)", attributes: endTimeAttrs)
    
    fullTimeRangeText.append(endTimeAttrString)
    
    
    
    return fullTimeRangeText
}

/*
 Turns cents to dollars as a string
*/
func centsToDollars(cents: Int) -> String {
    let dollars: Float = Float(cents)/100
    return "\(dollars)"
}

/*
 Formats the dollars string to have 2 decimal places and the dollar symbol.
*/
func formatDollars(dollars: String) -> String {
    let partsToADollar = dollars.split(separator: ".")
    let dollars = partsToADollar[0]
    var cents = partsToADollar[1]
    
    if(cents.count == 1){
        cents += "0"
    }
    
    return "$\(dollars).\(cents)"
}

/*
 Finds booster seat count in an array of waypoints
 -Checks passenger within every waypoint]
 -If booster_seat bool is true, adds their passengerID to an array.
 -If the passengerID already exists in the array, dont add the ID (only want unique IDs)
*/
func getBoosterSeatCount(in waypoints: [Waypoint]) -> Int {
    
    var passengersWhoNeedBoosterSeats: [Int] = []
    
    for waypoint in waypoints {
        for passenger in waypoint.passengers {
            if(passenger.booster_seat == true && !passengersWhoNeedBoosterSeats.contains(passenger.id)){
                passengersWhoNeedBoosterSeats.append(passenger.id)
            }
        }
    }
    
    return passengersWhoNeedBoosterSeats.count
}

/*
 Takes all waypoint addresses and constructs a numbered list of them.
 -Loops through all of the waypoints
 -Uses an int to track the current waypoint
 -Uses \n to ensure a new line for the next waypoint
*/
func constructWaypointsText(waypoints: [Waypoint]) -> String {
    
    var allWaypointsInRide = ""
    
    var currentWaypointNum = 1
    for waypoint in waypoints {
        allWaypointsInRide += "\(currentWaypointNum). \(waypoint.location.address)\n"
        currentWaypointNum += 1
    }
    
    return allWaypointsInRide
}

/*
 Returns the main color of the app
*/
func getMainColor() -> UIColor {
    return UIColor.init(red: 0.1, green: 0.26, blue: 0.43, alpha: 1.0)
}
