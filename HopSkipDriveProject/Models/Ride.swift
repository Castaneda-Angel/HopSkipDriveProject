//
//  Ride.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/26/21.
//

import Foundation

class Ride: Decodable {
    var trip_id: Int
    var in_series: Bool
    var starts_at: String
    var ends_at: String
    var estimated_earnings_cents: Int
    var estimated_ride_minutes: Int
    var estimated_ride_miles: Double
    var ordered_waypoints: [Waypoint]
    
    init(trip_id: Int, in_series: Bool, starts_at: String, ends_at: String, estimated_earnings_cents: Int, estimated_ride_minutes: Int, estimated_ride_miles: Double, ordered_waypoints: [Waypoint]) {
        self.trip_id = trip_id
        self.in_series = in_series
        self.starts_at = starts_at
        self.ends_at = ends_at
        self.estimated_earnings_cents = estimated_earnings_cents
        self.estimated_ride_minutes = estimated_ride_minutes
        self.estimated_ride_miles = estimated_ride_miles
        self.ordered_waypoints = ordered_waypoints
    }
    
}
