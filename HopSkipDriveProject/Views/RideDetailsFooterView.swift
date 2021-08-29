//
//  RideDetailsFooterView.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/29/21.
//

/*
 View for the WaypointsTableView footer.
*/

import UIKit
import SnapKit

class RideDetailsFooterView: UIView {
    
    lazy var miscRideInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    lazy var cancelTripButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        
        button.setTitle("Cancel This Trip", for: .normal)
        button.setTitleColor(.red, for: .normal)
        
        return button
    }()

    func addViews() {
        addSubview(miscRideInfoLabel)
        addSubview(cancelTripButton)
    }
    
    func addConstraints() {
        miscRideInfoLabel.snp_makeConstraints({ (make) -> Void in
            make.top.left.equalToSuperview().offset(20)
        })
        
        cancelTripButton.snp_makeConstraints({ (make) -> Void in
            make.left.right.equalToSuperview()
            make.top.equalTo(miscRideInfoLabel.snp_bottom).offset(20)
            make.height.equalTo(75)
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}