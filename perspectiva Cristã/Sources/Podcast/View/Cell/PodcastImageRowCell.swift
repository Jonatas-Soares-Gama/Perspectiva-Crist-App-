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
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var episodeImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.shadowOpacity = 0.5
        img.layer.shadowOffset = CGSize(width: 8, height: 6)
        img.layer.shadowRadius = 4
        img.clipsToBounds = false
        return img
    }()
    
    override func addSubviews() {
        addSubview(container)
        container.addSubview(episodeImage)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            episodeImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 30),
            episodeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            episodeImage.heightAnchor.constraint(equalToConstant: 250),
            episodeImage.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
}
