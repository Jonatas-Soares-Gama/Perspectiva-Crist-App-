//
//  PodcastScreen.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 16/06/23.
//

import Foundation
import UIKit

class PodcastScreen: BaseView {
        
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Perspectiva Cristã"
        label.font = .boldSystemFont(ofSize: 27)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Podcasts"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var liveImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "mic.fill")
        image.tintColor = .systemRed
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
        collectionView.delaysContentTouches = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(PodcastCollectionViewCell.self, forCellWithReuseIdentifier: PodcastCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    public func configCollectionViewProtocols(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource){
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = dataSource
    }
    
    override func addSubviews() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(liveImage)
        addSubview(collectionView)
    }
    
    override func setupConstrainst() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
            subTitleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: -3),
            
            liveImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
            liveImage.leadingAnchor.constraint(equalTo: subTitleLabel.trailingAnchor,constant: 3),
            
            collectionView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 30) ,
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
}
