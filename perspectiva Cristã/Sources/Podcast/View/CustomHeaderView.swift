//
//  PodcastFirstRowCell.swift
//  perspectiva Cristã
//
//  Created by Felipe Henrique Domingos on 17/07/23.
//

import Foundation
import UIKit

class CustomHeaderView: BaseView {
    
    lazy var container: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        addSubview(container)
        addSubview(episodeImage)
    }
    
    override func setupConstrainst() {
        NSLayoutConstraint.activate([
            
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            episodeImage.topAnchor.constraint(equalTo: topAnchor),
            episodeImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            episodeImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            episodeImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
//            episodeImage.centerYAnchor.constraint(equalTo: centerYAnchor),
//            episodeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
//            episodeImage.widthAnchor.constraint(equalToConstant: 300),
//            episodeImage.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
