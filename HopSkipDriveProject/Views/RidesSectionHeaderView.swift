//
//  RidesSectionHeaderView.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/28/21.
//

/*
 View for the RidesTableView section header.
*/

import UIKit
import SnapKit

class RidesSectionHeaderView: UIView {

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.sizeToFit()
        return label
    }()
    
    lazy var timeRangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    lazy var estimatedTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textAlignment = .right
        label.text = "ESTIMATED"
        label.textColor = UIColor.gray
        
        return label
    }()
    
    lazy var estimatedAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.sizeToFit()
        label.textAlignment = .right
        label.textColor = getMainColor()
        
        label.layoutMargins = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
        
        return label
    }()

    func addViews() {
        addSubview(dateLabel)
        addSubview(timeRangeLabel)
        addSubview(estimatedTextLabel)
        addSubview(estimatedAmountLabel)
    }
    
    func addConstraints() {
        dateLabel.snp_makeConstraints({ (make) -> Void in
            
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        })
        timeRangeLabel.snp_makeConstraints({ (make) -> Void in
            make.width.equalTo(175)

            make.left.equalTo(dateLabel.snp_right)
            make.top.bottom.equalToSuperview()
        })
        
        estimatedTextLabel.snp_makeConstraints({ (make) -> Void in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.height.lessThanOrEqualTo(10)
        })
        
        estimatedAmountLabel.snp_makeConstraints({ (make) -> Void in
            make.right.equalToSuperview().offset(-10)
            make.top.lessThanOrEqualTo(estimatedTextLabel.snp_bottom).offset(3)
            make.bottom.equalToSuperview().offset(-5)
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        
        
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
