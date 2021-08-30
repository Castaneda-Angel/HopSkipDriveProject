//
//  MyRidesExtension.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/30/21.
//

import Foundation
import UIKit

extension MyRidesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsData[section].sectionRides.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rideCell", for: indexPath) as! RideTableViewCell
        
        //construcs time range string for every ride
        var timeRangeForRide = NSMutableAttributedString()
        if let startDate = stringToDate(dateString: sectionsData[indexPath.section].sectionRides[indexPath.row].starts_at), let endDate = stringToDate(dateString: sectionsData[indexPath.section].sectionRides[indexPath.row].ends_at) {
            timeRangeForRide = constructTimeRangeString(from: startDate, to: endDate, isSmallText: false, isForHeader: false)
        }
        cell.timeRangeLabel.attributedText = timeRangeForRide
        
        
        //gets rider and booster seat counts
        //Riders are found by counting the passengers in each waypoint, and getting the max.
        let maxRiders = sectionsData[indexPath.section].sectionRides[indexPath.row].ordered_waypoints.map({ $0.passengers.count }).max()
        //booster seats found by passenger IDs that require them, making sure to only count 1 per ID.
        let boosterSeats = getBoosterSeatCount(in: sectionsData[indexPath.section].sectionRides[indexPath.row].ordered_waypoints)
        
        //makes the strings plural if needed
        let ridersString = "\(maxRiders ?? 0) \(maxRiders == 1 ? "rider" : "riders")"
        let boostersString = "\(boosterSeats != 0 ? " • \(boosterSeats) \(boosterSeats == 1 ? "booster" : "boosters")" : "")"
        
        cell.riderAndBoosterSeatCountLabel.text = "(\(ridersString)\(boostersString))"
        
        //formats the cents into a dollar amount in string form
        var estimatedDollars = centsToDollars(cents: sectionsData[indexPath.section].sectionRides[indexPath.row].estimated_earnings_cents)
        estimatedDollars = formatDollars(dollars: estimatedDollars)
        
        //Set attributes to the different parts of the full earnings text
        let smallerText = "est."
        let smallerTextAttrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : getMainColor()]
        let fullEarningsText = NSMutableAttributedString(string: smallerText, attributes: smallerTextAttrs)
        
        let dollarsText = " \(estimatedDollars)"
        let dollarsTextAttrs = [NSAttributedString.Key.foregroundColor : getMainColor(), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .medium)]
        let dollarsTextAttributedString = NSMutableAttributedString(string: dollarsText, attributes: dollarsTextAttrs)
        
        fullEarningsText.append(dollarsTextAttributedString)
        cell.estimatedEarningsLabel.attributedText = fullEarningsText
        
        //constructs addresses in a numbered format
        cell.waypointsLabel.text = constructWaypointsText(waypoints: sectionsData[indexPath.section].sectionRides[indexPath.row].ordered_waypoints)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Navigating to Ride Details Screen
        let rideDetailsVC = RideDetailsViewController()
        rideDetailsVC.ride = sectionsData[indexPath.section].sectionRides[indexPath.row]
        
        self.navigationController?.pushViewController(rideDetailsVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = RidesSectionHeaderView(frame: .zero)
        
        //sets attributes for the date
        let dateHeaderAttrs = [NSAttributedString.Key.foregroundColor: getMainColor(), NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        let dateHeaderAttributedString = NSMutableAttributedString(string: sectionsData[section].sectionHeader, attributes: dateHeaderAttrs)
        
        headerView.dateLabel.attributedText = dateHeaderAttributedString
        headerView.timeRangeLabel.attributedText = sectionsData[section].timeRange
        
        //sets font size of the "estimated" text to be smaller than Ride Detail header view
        headerView.estimatedTextLabel.font = UIFont.systemFont(ofSize: 13)
        
        headerView.estimatedAmountLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        headerView.estimatedAmountLabel.text = sectionsData[section].totalEstimatedEarnings
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
}
