//
//  PocastTableViewCell.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 16/06/23.


import UIKit

class PodcastCollectionViewCell: BaseViewCell {
    
    static let identifier: String = "PodcastCollectionViewCell"

    lazy var serviceView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.tintColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "TriviumCast-Episodio-001-mp3-image")
        return image
    }()
    
    
    override func addSubviews() {
        addSubview(serviceView)
        serviceView.addSubview(logoImage)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            
            serviceView.topAnchor.constraint(equalTo: topAnchor) ,
            serviceView.leadingAnchor.constraint(equalTo: leadingAnchor),
            serviceView.trailingAnchor.constraint(equalTo: trailingAnchor),
            serviceView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logoImage.topAnchor.constraint(equalTo: topAnchor) ,
            logoImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            logoImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
}
