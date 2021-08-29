//
//  RideDetailsView.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/28/21.
//

/*
 View for the RideDetails screen.
*/

import UIKit
import SnapKit
import MapKit

class RideDetailsView: UIView {

    var isSeries: Bool = false
    
    var informationHeaderView = RidesSectionHeaderView()

    var startAnnotation = MKPointAnnotation()
    var endAnnotation = MKPointAnnotation()
    lazy var startAndEndMapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isUserInteractionEnabled = false
        return mapView
    }()
    
    lazy var isSeriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.italicSystemFont(ofSize: 13)
        return label
    }()
    
    lazy var waypointsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    
    func addViews() {
        addSubview(informationHeaderView)
        addSubview(startAndEndMapView)
        addSubview(isSeriesLabel)
        addSubview(waypointsTableView)
    }
    
    func addConstraints() {
        informationHeaderView.snp_makeConstraints({ (make) -> Void in
            make.top.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(60)
        })
        startAndEndMapView.snp_makeConstraints({ (make) -> Void in
            make.top.equalTo(informationHeaderView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        })
        isSeriesLabel.snp_makeConstraints({ (make) -> Void in
            make.top.equalTo(startAndEndMapView.snp.bottom).offset(5)
            make.left.right.equalToSuperview().offset(5)
            if(isSeries == true){
                make.height.equalTo(20)
            }
        })
        waypointsTableView.snp_makeConstraints({ (make) -> Void in
            if(isSeries == true){
                make.top.equalTo(isSeriesLabel.snp.bottom).offset(5)
            }
            else{
                make.top.equalTo(startAndEndMapView.snp.bottom)
            }
            make.left.right.bottom.equalToSuperview()
        })
        
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    override func updateConstraints() {
        addConstraints()
        super.updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
