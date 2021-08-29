//
//  Waypoint.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/26/21.
//

import Foundation

class Waypoint: Decodable {
    
    var id: Int
    var anchor: Bool
    var passengers: [Passenger]
    var location: Location
    
    init(id: Int, anchor: Bool, passengers: [Passenger], location: Location) {
        self.id = id
        self.anchor = anchor
        self.passengers = passengers
        self.location = location
    }
    
}
