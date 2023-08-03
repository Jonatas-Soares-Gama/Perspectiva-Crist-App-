//
//  PodcastTableViewCell.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 25/06/23.
//

import Foundation
import WebKit


class PodcastTableViewCell: BaseTableViewCell {
    
    static let identifier: String = "PodcastTableViewCell"
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var episodeImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "grandesperguntas")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.shadowOpacity = 0.7
        img.layer.shadowOffset = CGSize(width: 4, height: 3)
        img.layer.shadowRadius = 4
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = false
        return img
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var episodesDuration: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override func addSubviews() {
        addSubview(container)
        container.addSubview(episodeImage)
        container.addSubview(titleLabel)
        container.addSubview(subTitleLabel)
        container.addSubview(episodesDuration)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            episodeImage.bottomAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: -8),
            episodeImage.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            episodeImage.heightAnchor.constraint(equalToConstant: 40),
            episodeImage.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: episodeImage.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: episodeImage.trailingAnchor, constant: 16),
            
            episodesDuration.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            episodesDuration.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
}

