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
    
    lazy var titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var episodesCountLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func addSubviews() {
        addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(episodesCountLabel)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleView.topAnchor.constraint(equalTo: topAnchor),
            titleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 16),

            episodesCountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            episodesCountLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 16),
        ])
    }
}
