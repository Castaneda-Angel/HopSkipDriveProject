//
//  MyRidesView.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/26/21.
//

/*
 View for the My Rides screen.
*/

import UIKit
import SnapKit

class MyRidesView: UIView {

    lazy var ridesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    
    func addViews() {
        addSubview(ridesTableView)
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    override func updateConstraints() {
        ridesTableView.snp_makeConstraints({ (make) -> Void in
            make.edges.equalToSuperview()
        })
        super.updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
