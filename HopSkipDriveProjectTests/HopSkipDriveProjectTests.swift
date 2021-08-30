//
//  HopSkipDriveProjectTests.swift
//  HopSkipDriveProjectTests
//
//  Created by Angel castaneda on 8/26/21.
//

import XCTest
@testable import HopSkipDriveProject

class HopSkipDriveProjectTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testDateToStringReturnsValidDate() {
        let stringDate = "6/10/2021"
        let testDate = stringToDate(dateString: stringDate, format: "M/dd/yyyy")
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 6
        dateComponents.day = 10
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        dateComponents.timeZone = TimeZone(abbreviation: "GMT")
        let calendar = Calendar(identifier: .gregorian)
        let dateShouldEqual = calendar.date(from: dateComponents)
        
        XCTAssertEqual(testDate, dateShouldEqual, "Date from string to date function is invalid")
    }
    
    func testDateToStringReturnsInvalidDate() {
        let stringDate = "6/10/2021"
        let testDate = stringToDate(dateString: stringDate, format: "yyyy/dd/M")
        
        var dateComponents = DateComponents()
        dateComponents.year = 2021
        dateComponents.month = 6
        dateComponents.day = 10
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        dateComponents.timeZone = TimeZone(abbreviation: "GMT")
        let calendar = Calendar(identifier: .gregorian)
        let dateShouldEqual = calendar.date(from: dateComponents)
        
        XCTAssertNotEqual(testDate, dateShouldEqual, "Date from string to date function is valid")
    }
    
    func testStringToDateReturnsValidDate() {
        
        let stringDate = "8/24/2010"
        
        var dateComponents = DateComponents()
        dateComponents.year = 2010
        dateComponents.month = 8
        dateComponents.day = 24
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        dateComponents.timeZone = TimeZone(abbreviation: "GMT")
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(from: dateComponents)
        
        let testDate = dateToString(date: date!, format: "M/dd/yyyy")
        
        XCTAssertEqual(testDate, stringDate, "String from date to string function is invalid")
    }
    
    func testStringToDateReturnsInvalidDate() {
        
        let stringDate = "8/24/2010"
        
        var dateComponents = DateComponents()
        dateComponents.year = 2010
        dateComponents.month = 8
        dateComponents.day = 24
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        dateComponents.timeZone = TimeZone(abbreviation: "GMT")
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(from: dateComponents)
        
        let testDate = dateToString(date: date!, format: "yyyy/dd/M")
        
        XCTAssertNotEqual(testDate, stringDate, "String from date to string function is valid")
    }
    
    func testTimeToIntReturnsCorrectInt() {
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 29
        dateComponents.second = 0
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(from: dateComponents)
        
        let testInt = timeToInt(date: date!)
        XCTAssertEqual(testInt, 629 , "Int is not correct")
        
    }
    
    func testTimeRangeFuncReturnsValidTimeRange() {
        var startComponents = DateComponents()
        startComponents.hour = 10
        startComponents.minute = 29
        startComponents.second = 0
        startComponents.timeZone = TimeZone(abbreviation: "GMT")
        let startCalendar = Calendar(identifier: .gregorian)
        let startDate = startCalendar.date(from: startComponents)
        
        var endComponents = DateComponents()
        endComponents.hour = 14
        endComponents.minute = 41
        endComponents.second = 0
        endComponents.timeZone = TimeZone(abbreviation: "GMT")
        let endCalendar = Calendar(identifier: .gregorian)
        let endDate = endCalendar.date(from: endComponents)
        
        let testRange = constructTimeRangeString(from: startDate!, to: endDate!, isSmallText: false, isForHeader: false).string
        
        XCTAssertEqual(testRange, "10:29a - 2:41p", "Time range is not correct")
    }
    
    func testCentsReturnsCorrectDollars() {
        let cents = 432
        
        let testDollars = centsToDollars(cents: cents)
        
        XCTAssertEqual(testDollars, "4.32", "Dollar string is not correct")
    }
    
    func testFormatDollarsShouldReturnCorrectFormat() {
        let dollarsString = "5.2"
        
        let testFormat = formatDollars(dollars: dollarsString)
        
        XCTAssertEqual(testFormat, "$5.20")
    }
    
    func testBoosterSeatCounterReturnsCorrectInt() {
        let testWaypoint = Waypoint(id: 123, anchor: true, passengers: [Passenger(id: 1, booster_seat: true, first_name: "A"), Passenger(id: 2, booster_seat: false, first_name: "B"), Passenger(id: 1, booster_seat: true, first_name: "A")], location: Location(address: "123 Test St.", lat: -100.15832, lng: 93.893475))
        
        let testBoosterSeatCount = getBoosterSeatCount(in: [testWaypoint])
        
        XCTAssertEqual(testBoosterSeatCount, 1, "Booster seat count is incorrect")
    }
    
    func testConstructedWaypointStringIsValid() {
        let testWaypoints = [Waypoint(id: 123, anchor: true, passengers: [Passenger(id: 1, booster_seat: true, first_name: "A"), Passenger(id: 2, booster_seat: false, first_name: "B"), Passenger(id: 1, booster_seat: true, first_name: "A")], location: Location(address: "123 Test St.", lat: -100.15832, lng: 93.893475)), Waypoint(id: 321, anchor: false, passengers: [Passenger(id: 2, booster_seat: false, first_name: "B")], location: Location(address: "321 Test Ave.", lat: -129.7428217, lng: 76.736353))]
        
        let testString = constructWaypointsText(waypoints: testWaypoints)
        
        XCTAssertEqual(testString, "1. 123 Test St.\n2. 321 Test Ave.\n", "Waypoints String is incorrect")
    }

}
