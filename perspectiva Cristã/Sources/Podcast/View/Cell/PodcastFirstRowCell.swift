//
//  PodcastFirstRowCell.swift
//  perspectiva Cristã
//
//  Created by Felipe Henrique Domingos on 17/07/23.
//

import Foundation
import UIKit

class PodcastFirstRowCell: BaseTableViewCell {
    
    static let identifier: String = "PodcastFirstRowCell"
    
    lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var episodeImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var episodeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func addSubviews() {
        addSubview(container)
        container.addSubview(episodeImage)
        container.addSubview(episodeTitle)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            episodeImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 30),
            episodeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            episodeImage.heightAnchor.constraint(equalToConstant: 200),
            episodeImage.widthAnchor.constraint(equalToConstant: 200),
            
            episodeTitle.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            episodeTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
