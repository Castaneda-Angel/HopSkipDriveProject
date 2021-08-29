//
//  Section.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/27/21.
//

/*
Custom Section class to easily store data for each section.
*/

import Foundation

class Section {
    
    var sectionHeader: String
    var dateOfSection: Date
    var timeRange: NSMutableAttributedString
    var totalEstimatedEarnings: String
    var sectionRides: [Ride]
    
    init(sectionHeader: String, dateOfSection: Date, timeRange: NSMutableAttributedString, totalEstimatedEarnings: String, sectionRides: [Ride]) {
        self.sectionHeader = sectionHeader
        self.dateOfSection = dateOfSection
        self.timeRange = timeRange
        self.totalEstimatedEarnings = totalEstimatedEarnings
        self.sectionRides = sectionRides
    }
    
}
