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
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        view.alpha = 0.5
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var episodeImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "grandesperguntas")
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
        container.addSubview(episodeImage)
    }
    
    override func setupConstrainst() {
        NSLayoutConstraint.activate([
            
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            episodeImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            episodeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            episodeImage.widthAnchor.constraint(equalToConstant: 260),
            episodeImage.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
}
