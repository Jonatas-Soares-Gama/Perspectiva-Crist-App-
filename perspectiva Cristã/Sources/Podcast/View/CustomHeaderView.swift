//
//  PodcastFirstRowCell.swift
//  perspectiva Cristã
//
//  Created by Felipe Henrique Domingos on 17/07/23.
//

import Foundation
import UIKit

class CustomHeaderView: BaseView {
    
    lazy var episodeImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.shadowOpacity = 0.7
        img.layer.shadowOffset = CGSize(width: 8, height: 6)
        img.layer.shadowRadius = 4
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = false
        return img
    }()
    
    override func addSubviews() {
        addSubview(episodeImage)
    }
    
    override func setupConstrainst() {
        NSLayoutConstraint.activate([
            
            episodeImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            episodeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            episodeImage.widthAnchor.constraint(equalToConstant: 350),
            episodeImage.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
}
