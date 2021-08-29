//
//  MyRidesViewController.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/26/21.
//

import UIKit
import SnapKit

class MyRidesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Model and the View
    var networkCalls = NetworkCalls()
    let myRidesView = MyRidesView(frame: .zero)
    
    //Data source for tableview
    var sectionsData: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkCalls.getRides(completionHandler: {
            (allRides) in
            self.getTableViewSetupData(rides: allRides)
        })
        
        //View setup
        self.view.backgroundColor = .white
        self.title = "My Rides"
        self.view.addSubview(myRidesView)
        
        //Main TableView setup
        myRidesView.ridesTableView.delegate = self
        myRidesView.ridesTableView.dataSource = self
        myRidesView.ridesTableView.register(RideTableViewCell.self, forCellReuseIdentifier: "rideCell")
        myRidesView.snp_makeConstraints({ (make) -> Void in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        })

    }
    
    
    //Table View
    func getTableViewSetupData(rides: [Ride]) {
        
        //dictionary to hold the sections, for every date, there is an array of rides.
        var sections: [String:[Ride]] = [:]
        
        //separate rides into sections depending on the date
        for ride in rides {
            if let startsAt = stringToDate(dateString: ride.starts_at){
                let sectionHeader = dateToString(date: startsAt, format: "MM/dd/yyyy")
                
                //check to see if that date already exists in the dictionary
                if var ridesArray = sections[sectionHeader]{
                    ridesArray.append(ride)
                    sections[sectionHeader] = ridesArray
                }
                else{
                    sections[sectionHeader] = [ride]
                }
            }
        }
        
        //get time range for the section, add total estimated earnings, add to a new object 'Section'
        for (header, rides) in sections {
            
            var totalEarningsInSection = 0
            
            var earliestTime: Date?
            var latestTime: Date?
            
            //Compare every start and end time to find the earliest and the latest.
            //Compares by turning the hours and minutes into an integer
            for sectionRide in rides {
                guard let startDate = stringToDate(dateString: sectionRide.starts_at) else { return }
                guard let endDate = stringToDate(dateString: sectionRide.ends_at) else { return }
                
                if(earliestTime == nil){
                    earliestTime = startDate
                }
                else if(timeToInt(date: earliestTime!) > timeToInt(date: startDate)){
                    earliestTime = startDate
                }
                
                if(latestTime == nil){
                    latestTime = endDate
                }
                else if(timeToInt(date: latestTime!) < timeToInt(date: endDate)){
                    latestTime = endDate
                }
                
                totalEarningsInSection += sectionRide.estimated_earnings_cents
            }
            
            var rangeForSection = NSMutableAttributedString()
            if let earliestTime = earliestTime, let latestTime = latestTime {
                rangeForSection = constructTimeRangeString(from: earliestTime, to: latestTime, isSmallText: true, isForHeader: true)
            }
            
            //Turning estimated total earnings from cents to dollars
            let dollarsString = centsToDollars(cents: totalEarningsInSection)
            let formattedDollars = formatDollars(dollars: dollarsString)
            
            //Turns the header dateString back into a date object so that it can be sorted.
            if let headerDate = stringToDate(dateString: header, format: "MM/dd/yyyy"){
                let newSection = Section(sectionHeader: dateToString(date: headerDate, format: "E M/d"), dateOfSection: headerDate, timeRange: rangeForSection, totalEstimatedEarnings: formattedDollars, sectionRides: rides)
                
                sectionsData.append(newSection)
            }
        }
        
        //Sorts sections so that the earliest dates are first.
        //dictionaries dont guarantee order
        sectionsData.sort(by: { $0.dateOfSection < $1.dateOfSection })
    
        DispatchQueue.main.async {
            //reloads table view after all the data is organized/formatted
            self.myRidesView.ridesTableView.reloadData()
        }
        
    }
    
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
        let smallerTextAttrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : getMainColor()]
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
