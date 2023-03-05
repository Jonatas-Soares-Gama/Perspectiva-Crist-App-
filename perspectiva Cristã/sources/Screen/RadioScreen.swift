//
//  RadioScreen.swift
//  perspectiva Cristã
//
//  Created by Jonatas Gama on 25/02/23.
//

import Foundation
import UIKit
import AVFoundation

protocol RadioProtocol: AnyObject {
    func actionPlayButton()
    func actionPauseButton()
}

class RadioScreen: UIView {
    
    weak var delegate:RadioProtocol?
    func delegate(delegate:RadioProtocol?){
        self.delegate = delegate
    }
    
    var audioPlayer: AVPlayer?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rádio -"
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .white
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ao vivo"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .systemRed
        return label
    }()
    
    lazy var liveImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "dot.radiowaves.left.and.right")
        image.tintColor = .systemRed
        return image
    }()
    
    
    lazy var backimage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "back")
        return image
    }()
    
    lazy var radioImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "radioAzul2")
        image.sizeToFit()
        return image
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        button.tintColor = UIColor(red: 254/255, green: 78/255, blue: 2/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.ButtonPlayButton), for: .touchUpInside)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 80), forImageIn: .normal)
        return button
    }()
    
    lazy var pauseButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        button.tintColor = .blue
        button.addTarget(self, action: #selector(self.ButtonPauseButton), for: .touchUpInside)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 80), forImageIn: .normal)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backimage)
        addSubview(radioImage)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(liveImage)
        addSubview(playButton)
        addSubview(pauseButton)
        setupConstrainst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func ButtonPlayButton() {
        self.delegate?.actionPlayButton()
    }
    
    @objc func ButtonPauseButton() {
        self.delegate?.actionPauseButton()
    }
    
    func playMusic(data: List) {
        DispatchQueue.main.async {
            guard let musicURL = URL(string: data.station?.listenURL ?? "") else { return }
            self.audioPlayer = AVPlayer(url: musicURL)
            self.audioPlayer?.play()
            self.playButton.isHidden = true
            self.pauseButton.isHidden = false
        }
    }
    
    func pauseMusic(data: List) {
        DispatchQueue.main.async {
            self.audioPlayer?.pause()
            self.pauseButton.isHidden = true
            self.playButton.isHidden = false
        }
    }
    
    func setupConstrainst() {
        NSLayoutConstraint.activate([
            backimage.topAnchor.constraint(equalTo: topAnchor),
            backimage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backimage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backimage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 50),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor,constant: 15),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor,constant: 5),
            
            liveImage.topAnchor.constraint(equalTo: subTitleLabel.topAnchor),
            liveImage.leadingAnchor.constraint(equalTo: subTitleLabel.trailingAnchor,constant: 3),
            
            radioImage.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor,constant: 150),
            radioImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            radioImage.heightAnchor.constraint(equalToConstant: 270),
            radioImage.widthAnchor.constraint(equalToConstant: 270),
            
            playButton.topAnchor.constraint(equalTo: radioImage.bottomAnchor,constant: 80),
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            pauseButton.topAnchor.constraint(equalTo: radioImage.bottomAnchor,constant: 80),
            pauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
    }
    
}
