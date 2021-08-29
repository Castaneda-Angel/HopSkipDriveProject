//
//  BackButton.swift
//  HopSkipDriveProject
//
//  Created by Angel castaneda on 8/29/21.
//

import UIKit

class BackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let backArrayConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium)
        let backArrowImage = UIImage(systemName: "arrow.left", withConfiguration: backArrayConfig)
        
        self.setImage(backArrowImage, for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
