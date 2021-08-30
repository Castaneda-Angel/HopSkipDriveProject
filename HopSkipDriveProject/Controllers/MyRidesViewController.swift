//
//  MyRidesViewController.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/26/21.
//

import UIKit
import SnapKit

class MyRidesViewController: UIViewController {
    
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
    
}
