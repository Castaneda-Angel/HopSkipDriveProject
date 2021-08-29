//
//  WaypointTableViewCell.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/29/21.
//

/*
 View for the WaypointsTableView cell.
*/

import UIKit

class WaypointTableViewCell: UITableViewCell {

    lazy var typeImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    
    func addSubviews() {
        addSubview(typeImage)
        addSubview(typeLabel)
        addSubview(addressLabel)
    }
    
    func addConstraints() {
        typeImage.snp_makeConstraints({ (make) -> Void in
            make.left.top.equalToSuperview().offset(20)
        })
        typeLabel.snp_makeConstraints({ (make) -> Void in
            make.left.equalTo(typeImage.snp_right).offset(5)
            make.top.equalToSuperview().offset(20)
            make.centerY.equalTo(typeImage.snp_centerY)
        })
        addressLabel.snp_makeConstraints({ (make) -> Void in
            make.left.equalTo(typeImage.snp_right).offset(5)
            make.top.equalTo(typeLabel.snp_bottom).offset(10)
        })
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
