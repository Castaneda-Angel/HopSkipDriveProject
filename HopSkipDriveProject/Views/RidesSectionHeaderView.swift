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
        
        
        return label
    }()
    
    lazy var timeRangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    lazy var estimatedTotalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textAlignment = .right
        
        return label
    }()

    func addViews() {
        addSubview(dateLabel)
        addSubview(timeRangeLabel)
        addSubview(estimatedTotalLabel)
    }
    
    func addConstraints() {
        dateLabel.snp_makeConstraints({ (make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(75)
            
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        })
        timeRangeLabel.snp_makeConstraints({ (make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(175)

            make.left.equalTo(dateLabel.snp_right)
            make.top.bottom.equalToSuperview()
        })
        estimatedTotalLabel.snp_makeConstraints({ (make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(100)

            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
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
