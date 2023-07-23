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
    
    override func addSubviews() {
        addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(subTitleLabel)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            subTitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5)
        ])
    }
}

