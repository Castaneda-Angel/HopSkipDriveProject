//
//  RideDetailsViewController.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/28/21.
//

import UIKit
import SnapKit
import MapKit

class RideDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate {

    //Selected ride
    var ride: Ride?
    
    //Views
    let rideDetailsView = RideDetailsView()
    let tableFooterView = RideDetailsFooterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //View setup
        self.title = "Ride Details"
        self.view.backgroundColor = .white
        
        rideDetailsView.isSeries = ride!.in_series
        self.view.addSubview(rideDetailsView)
        
        rideDetailsView.snp_makeConstraints({ (make) -> Void in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        })
        
        //Waypoints TableView setup
        rideDetailsView.waypointsTableView.delegate = self
        rideDetailsView.waypointsTableView.dataSource  = self
        rideDetailsView.waypointsTableView.register(WaypointTableViewCell.self, forCellReuseIdentifier: "waypointCell")
        rideDetailsView.waypointsTableView.tableFooterView = tableFooterView
        
        //MapView setup
        rideDetailsView.startAndEndMapView.delegate = self
        rideDetailsView.startAndEndMapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: "mapAnnotation")
        
        populateViews()
    }
    
    func populateViews() {
        
        //constructs the date/time ranges for the header
        var timeRange = ""
        var dateForHeader = ""
        if let startDate = stringToDate(dateString: ride!.starts_at), let endDate = stringToDate(dateString: ride!.ends_at) {
            
            timeRange = constructTimeRangeString(from: startDate, to: endDate)
            dateForHeader = dateToString(date: startDate, format: "E M/d")
        }
        
        rideDetailsView.informationHeaderView.dateLabel.text = dateForHeader
        rideDetailsView.informationHeaderView.timeRangeLabel.text = timeRange
        
        //gets dollar amount from cents
        let estimatedDollars = centsToDollars(cents: ride!.estimated_earnings_cents)
        
        rideDetailsView.informationHeaderView.estimatedTotalLabel.text = formatDollars(dollars: estimatedDollars)
        
        //shows the series text if it's actually a series
        if(ride!.in_series == true){
            rideDetailsView.isSeriesLabel.text = "This trip is part of a series."
        }
        
        tableFooterView.miscRideInfoLabel.text = "Trip ID: \(ride!.trip_id) • \(ride!.estimated_ride_miles) mi • \(ride!.estimated_ride_minutes) min"
        
        
        //sets map annotations for the start and end waypoints.
        rideDetailsView.startAnnotation.coordinate = CLLocationCoordinate2D(latitude: ride!.ordered_waypoints[0].location.lat, longitude: ride!.ordered_waypoints[0].location.lng)
        
        rideDetailsView.endAnnotation.coordinate = CLLocationCoordinate2D(latitude: ride!.ordered_waypoints[ride!.ordered_waypoints.count-1].location.lat, longitude: ride!.ordered_waypoints[ride!.ordered_waypoints.count-1].location.lng)
        
        rideDetailsView.startAndEndMapView.addAnnotations([rideDetailsView.startAnnotation, rideDetailsView.endAnnotation])
        
        rideDetailsView.startAndEndMapView.showAnnotations(rideDetailsView.startAndEndMapView.annotations, animated: false)
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ride!.ordered_waypoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "waypointCell", for: indexPath) as! WaypointTableViewCell
        
        //Shows different icons and text depending on if it's the dropoff waypoint
        let isDropOff = indexPath.row+1 == ride!.ordered_waypoints.count
        
        let typeImage = UIImage(systemName: !isDropOff ? "diamond.fill" : "circle.fill")
        cell.typeImage.image = typeImage
        cell.typeImage.tintColor = UIColor(red: 0.18, green: 0.72, blue: 0.9, alpha: 1.0)
        
        cell.typeLabel.text = !isDropOff ? "Pickup" : "Drop-off"
        
        cell.addressLabel.text = ride!.ordered_waypoints[indexPath.row].location.address
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //sets custom images (circles) for the annotations, green for the start and red for the end
        let annotView = MKAnnotationView(annotation: annotation, reuseIdentifier: "mapAnnotation")
        
        if((annotation.coordinate.latitude == ride!.ordered_waypoints[0].location.lat) && (annotation.coordinate.longitude == ride!.ordered_waypoints[0].location.lng)){
            //is start
            annotView.image = UIImage(systemName: "circle.fill")?.colorized(color: .green)
            annotView.tintColor = UIColor.green
        }
        else if((annotation.coordinate.latitude == ride!.ordered_waypoints[ride!.ordered_waypoints.count-1].location.lat) && (annotation.coordinate.longitude == ride!.ordered_waypoints[ride!.ordered_waypoints.count-1].location.lng)){
            //is end
            annotView.image = UIImage(systemName: "circle.fill")?.colorized(color: .red)
            
        }
        
        return annotView
    }

}

//Changes the map annotation color.
//Usually, hanging the tint color of the view changes the UIImage color. That doesn't work for MKAnnotationView, so a custom color changing function is needed.
extension UIImage {
    func colorized(color : UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        
        draw(in: rect)
        
        context!.clip(to: rect, mask: self.cgImage!)
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let colorizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return colorizedImage!
    }
}