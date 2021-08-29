//
//  Passenger.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/26/21.
//

import Foundation

class Passenger: Decodable {
    
    var id: Int
    var booster_seat: Bool
    var first_name: String
    
    init(id: Int, booster_seat: Bool, first_name: String) {
        self.id = id
        self.booster_seat = booster_seat
        self.first_name = first_name
    }
}
