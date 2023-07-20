//
//  BaseView.swift
//  perspectiva Cristã
//
//  Created by Kaue Ludovico on 28/03/23.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstrainst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        // Do Nothing
    }
    
    func setupConstrainst() {
        // Do Nothing
    }
}
