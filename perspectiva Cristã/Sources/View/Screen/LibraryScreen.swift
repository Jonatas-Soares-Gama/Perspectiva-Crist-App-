//
//  LabraryScreen.swift
//  perspectiva Cristã
//
//  Created by Jonatas Gama on 25/02/23.
//

import UIKit

class LibraryScreen: UIView {
    
    lazy var temporalyMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Em breve! \nEstudos e podcasts \npara a edificação\ndo seu dia."
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(temporalyMessage)
        
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            temporalyMessage.centerXAnchor.constraint(equalTo: centerXAnchor),
            temporalyMessage.centerYAnchor.constraint(equalTo: centerYAnchor),
            temporalyMessage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 50),
            temporalyMessage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: 50),
        ])
    }
    
}

