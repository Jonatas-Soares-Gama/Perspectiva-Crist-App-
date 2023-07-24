//
//  PodcastFirstRowCell.swift
//  perspectiva Cristã
//
//  Created by Felipe Henrique Domingos on 17/07/23.
//

import Foundation
import UIKit

class PodcastImageRowCell: BaseTableViewCell {
    
    static let identifier: String = "PodcastFirstRowCell"
    
    lazy var bgImage: UIImageView = {
        let img = UIImageView()
        img.alpha = 0.5
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var episodeImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.shadowOpacity = 0.7
        img.layer.shadowOffset = CGSize(width: 8, height: 6)
        img.layer.shadowRadius = 4
        img.clipsToBounds = false
        return img
    }()
    
    override func addSubviews() {
        addSubview(bgImage)
        addSubview(episodeImage)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: topAnchor),
            bgImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            episodeImage.topAnchor.constraint(equalTo: bgImage.topAnchor, constant: 80),
            episodeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            episodeImage.heightAnchor.constraint(equalToConstant: 270),
            episodeImage.widthAnchor.constraint(equalToConstant: 270),
        ])
    }
}
