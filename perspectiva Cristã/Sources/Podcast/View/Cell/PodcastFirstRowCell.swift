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
    
    lazy var container: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var bgImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.alpha = 0.85
        img.contentMode = .scaleAspectFill
        return img
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
    
    lazy var titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func addSubviews() {
        addSubview(container)
        container.addSubview(titleView)
        container.addSubview(bgImage)
        container.addSubview(episodeImage)
        container.addSubview(titleLabel)
    }
    
    override func setupConstraints() {
        
                NSLayoutConstraint.activate([
            
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            titleView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            
            bgImage.topAnchor.constraint(equalTo: topAnchor),
            bgImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            episodeImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            episodeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            episodeImage.widthAnchor.constraint(equalToConstant: 300),
            episodeImage.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 300)
    }
}
