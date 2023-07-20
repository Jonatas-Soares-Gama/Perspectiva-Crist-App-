//
//  BaseCollectionView.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 16/06/23.
//

import Foundation

import UIKit

class BaseViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        // Do nothing
    }
    
    func configureConstraints() {
        // Do nothing
    }
}
