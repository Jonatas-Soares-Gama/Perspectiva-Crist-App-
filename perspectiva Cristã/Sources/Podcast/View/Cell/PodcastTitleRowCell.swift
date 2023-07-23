//
//  PodcastTitleRowCell.swift
//  perspectiva Cristã
//
//  Created by Felipe Henrique Domingos on 21/07/23.
//

//
//  PodcastFirstRowCell.swift
//  perspectiva Cristã
//
//  Created by Felipe Henrique Domingos on 17/07/23.
//

import Foundation
import UIKit

class PodcastTitleRowCell: BaseTableViewCell {
    
    static let identifier: String = "PodcastTitleRowCell"
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var episodeTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func addSubviews() {
        addSubview(container)
        container.addSubview(episodeTitle)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            episodeTitle.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5),
            episodeTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
