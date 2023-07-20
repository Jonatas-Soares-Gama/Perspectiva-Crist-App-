//
//  BaseTableViewCell.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 25/06/23.
//

import Foundation
//
//  CarDetailTableViewCell.swift
//  introViewCode
//
//  Created by Felipe Domingos on 21/11/22.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubviews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        // Do nothing
    }
    
    func setupConstraints() {
        // Do nothing
    }
}

