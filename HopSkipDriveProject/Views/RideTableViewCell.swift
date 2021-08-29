//
//  RideTableViewCell.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/28/21.
//

/*
 View for the RidesTableView cell.
*/

import UIKit
import SnapKit

class RideTableViewCell: UITableViewCell {

    lazy var timeRangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var riderAndBoosterSeatCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    lazy var estimatedEarningsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var waypointsLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        
        return label
    }()
    
    
    func addSubviews() {
        addSubview(timeRangeLabel)
        addSubview(riderAndBoosterSeatCountLabel)
        addSubview(estimatedEarningsLabel)
        addSubview(waypointsLabel)
    }
    
    func addConstraints() {
        timeRangeLabel.snp_makeConstraints({ (make) -> Void in
            make.left.top.equalToSuperview().offset(20)
        })
        
        riderAndBoosterSeatCountLabel.snp_makeConstraints({ (make) -> Void in
            make.left.equalTo(timeRangeLabel.snp_right).offset(5)
            make.top.equalToSuperview().offset(20)
            make.centerY.equalTo(timeRangeLabel.snp_centerY)
        })
        
        estimatedEarningsLabel.snp_makeConstraints({ (make) -> Void in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        })
        
        waypointsLabel.snp_makeConstraints({ (make) -> Void in
            make.top.equalTo(timeRangeLabel.snp_bottom).offset(10)
            make.left.right.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-5)
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.black.withAlphaComponent(0.75).cgColor
        
        self.selectionStyle = .none
        
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
