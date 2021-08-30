//
//  WaypointTableViewFooterCell.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/30/21.
//

import UIKit

class WaypointTableViewFooterCell: UITableViewCell {

    lazy var miscRideInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    lazy var cancelTripButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        
        button.setTitle("Cancel This Trip", for: .normal)
        button.setTitleColor(.red, for: .normal)
        
        return button
    }()
    
    func addSubviews() {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
