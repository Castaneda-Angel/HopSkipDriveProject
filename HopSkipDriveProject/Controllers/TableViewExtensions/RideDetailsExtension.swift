//
//  RideDetailsExtension.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/30/21.
//

import Foundation
import UIKit

extension RideDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ride!.ordered_waypoints.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == (ride!.ordered_waypoints.count)){
            let cell = tableView.dequeueReusableCell(withIdentifier: "footerCell", for: indexPath) as! WaypointTableViewFooterCell
            
            cell.miscRideInfoLabel.text = "Trip ID: \(ride!.trip_id) • \(ride!.estimated_ride_miles) mi • \(ride!.estimated_ride_minutes) min"
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "waypointCell", for: indexPath) as! WaypointTableViewCell
            
            //Shows different icons/text depending on if it's the anchor/dropoff waypoint
            let isDropOff = indexPath.row+1 == ride!.ordered_waypoints.count
            
            let typeImage = UIImage(systemName: ride!.ordered_waypoints[indexPath.row].anchor == true ? "diamond.fill" : "circle.fill")
            cell.typeImage.image = typeImage
            cell.typeImage.tintColor = UIColor(red: 0.18, green: 0.72, blue: 0.9, alpha: 1.0)
            
            cell.typeLabel.text = !isDropOff ? "Pickup" : "Drop-off"
            
            cell.addressLabel.text = ride!.ordered_waypoints[indexPath.row].location.address
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == ride!.ordered_waypoints.count){
            return 140
        }
        else{
            return 100
        }
    }
    
}
