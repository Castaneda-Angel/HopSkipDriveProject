//
//  Location.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/26/21.
//

import Foundation

class Location: Decodable {
    
    var address: String
    var lat: Double
    var lng: Double
    
    init(address: String, lat: Double, lng: Double) {
        self.address = address
        self.lat = lat
        self.lng = lng
    }
}
