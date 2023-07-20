//
//  RadioScreen.swift
//  perspectiva Cristã
//
//  Created by Jonatas Gama on 25/02/23.
//

import AVFoundation
import UIKit

class RadioScreen: BaseView {
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
        return view
    }()
    
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
        label.text = "Ao vivo"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var liveImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "dot.radiowaves.left.and.right")
        image.tintColor = .systemRed
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var radioImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "radioAzul2")
        image.sizeToFit()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.shadowOpacity = 0.5
        image.layer.shadowOffset = CGSize(width: 8, height: 6)
        image.layer.shadowRadius = 4
        image.clipsToBounds = false
        return image
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 80), forImageIn: .normal)
        return button
    }()
    
    lazy var pauseButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        button.tintColor = .white
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 80), forImageIn: .normal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var titlePlayLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var artistPlayLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func addSubviews() {
     addSubview(backgroundView)
        backgroundView.addSubview(radioImage)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(subTitleLabel)
        backgroundView.addSubview(liveImage)
        backgroundView.addSubview(playButton)
        backgroundView.addSubview(pauseButton)
        backgroundView.addSubview(titlePlayLabel)
        backgroundView.addSubview(artistPlayLabel)
    }
    
    override func setupConstrainst() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor,constant: 90),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
            subTitleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: -3),
            
            liveImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
            liveImage.leadingAnchor.constraint(equalTo: subTitleLabel.trailingAnchor,constant: 3),
            
            radioImage.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor,constant: 25),
            radioImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            radioImage.heightAnchor.constraint(equalToConstant: 350),
            radioImage.widthAnchor.constraint(equalToConstant: 350),
            
            titlePlayLabel.topAnchor.constraint(equalTo: radioImage.bottomAnchor,constant: 35),
            titlePlayLabel.leadingAnchor.constraint(equalTo: radioImage.leadingAnchor),
            titlePlayLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 10),
            
            artistPlayLabel.topAnchor.constraint(equalTo: titlePlayLabel.bottomAnchor,constant: 5),
            artistPlayLabel.leadingAnchor.constraint(equalTo: radioImage.leadingAnchor),
            artistPlayLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 10),
            
            playButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -100),
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            pauseButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -100),
            pauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
