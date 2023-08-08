//
//  DonationScreen.swift
//  perspectiva Cristã
//
//  Created by Jonatas Gama on 27/06/23.
//

import UIKit
import WebKit

class DonationScreen: BaseView {
    
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
        label.text = "Doação"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var liveImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "heart.fill")
        image.tintColor = .systemRed
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var dataPixContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 8, height: 6)
        view.layer.shadowRadius = 4
        view.clipsToBounds = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    lazy var namePix: UILabel = {
        let label = UILabel()
        label.text = "beneficiário(a): \nMARALICE FERREIRA BATISTA"
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLineSpacing(lineSpacing: 4)
        return label
    }()
    
    lazy var descriptionPix: UILabel = {
        let label = UILabel()
        label.text = "descrição: \nApoio à Rádio Perspectiva Cristã"
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLineSpacing(lineSpacing: 4)
        return label
    }()
    
    lazy var keyPixContainer: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 8, height: 6)
        view.layer.shadowRadius = 4
        view.clipsToBounds = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    lazy var titleCopyPastePix: UILabel = {
        let label = UILabel()
        label.text = "clique aqui e copie o código \nabaixo para pagar via Pix"
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var copyImage: UIImageView = {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        img.image = UIImage(systemName: "doc.on.doc")
        img.tintColor = .systemRed
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var copyPastePix: UILabel = {
        let label = UILabel()
        label.text = "00020126920014BR.GOV.BCB.PIX0134radiopersp\nectivacrista@outlook.com0232Apoio a Radio Pers\npectiva Crista5204000053039865802BR5925MA\nRALICE FERREIRA BATISTA6009SAO PAULO6226\n052269qRDUyyG17LEAmbYXhVBq6304E28E"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var copyPastePixAlert: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 8, height: 6)
        view.layer.shadowRadius = 4
        view.clipsToBounds = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .cyan
        view.isHidden = true
        return view
    }()
    
    lazy var alertContentLabel: UILabel = {
        let label = UILabel()
        label.text = "Chave Pix copiado para área de transferência"
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var qrcodePixContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 8, height: 6)
        view.layer.shadowRadius = 4
        view.clipsToBounds = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    lazy var titleQrcodePix: UILabel = {
        let label = UILabel()
        label.text = "se preferir, leia o QR Code® Pix com seu app de pagamentos"
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var qrcodeImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Qrcode")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var keyPixLabel: UILabel = {
        let label = UILabel()
        label.text = "chave Pix e-mail: \nradioperspectivacrista@outlook.com"
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLineSpacing(lineSpacing: 4)
        return label
    }()
    
    @objc func viewTapped() {
        // Ação a ser executada quando a UIView (myView) for clicada
        print("A UIView foi clicada!")
    }
    
    override func addSubviews() {
        addSubview(backgroundView)
        backgroundView.addSubview(titleLabel)
        backgroundView.addSubview(subTitleLabel)
        backgroundView.addSubview(liveImage)
        backgroundView.addSubview(dataPixContainer)
        dataPixContainer.addSubview(namePix)
        dataPixContainer.addSubview(descriptionPix)
        backgroundView.addSubview(keyPixContainer)
        keyPixContainer.addSubview(copyImage)
        keyPixContainer.addSubview(titleCopyPastePix)
        keyPixContainer.addSubview(copyPastePix)
        backgroundView.addSubview(qrcodePixContainer)
        qrcodePixContainer.addSubview(titleQrcodePix)
        qrcodePixContainer.addSubview(qrcodeImage)
        qrcodePixContainer.addSubview(keyPixLabel)
        backgroundView.addSubview(copyPastePixAlert)
        copyPastePixAlert.addSubview(alertContentLabel)
    }
    
    override func setupConstrainst() {
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            copyPastePixAlert.centerXAnchor.constraint(equalTo: centerXAnchor),
            copyPastePixAlert.topAnchor.constraint(equalTo: topAnchor, constant: -30),
            copyPastePixAlert.heightAnchor.constraint(equalToConstant: 50),
            copyPastePixAlert.widthAnchor.constraint(equalToConstant: 380),
            
            alertContentLabel.centerXAnchor.constraint(equalTo: copyPastePixAlert.centerXAnchor),
            alertContentLabel.centerYAnchor.constraint(equalTo: copyPastePixAlert.centerYAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
            subTitleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: -3),
            
            liveImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10),
            liveImage.leadingAnchor.constraint(equalTo: subTitleLabel.trailingAnchor,constant: 3),
            
            dataPixContainer.topAnchor.constraint(equalTo: liveImage.bottomAnchor, constant: 20),
            dataPixContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            dataPixContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            dataPixContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            dataPixContainer.heightAnchor.constraint(equalToConstant: 120),
            
            namePix.topAnchor.constraint(equalTo: dataPixContainer.topAnchor, constant: 10),
            namePix.leadingAnchor.constraint(equalTo: keyPixContainer.leadingAnchor, constant: 16),
            namePix.trailingAnchor.constraint(equalTo: keyPixContainer.trailingAnchor, constant: -16),
            
            descriptionPix.topAnchor.constraint(equalTo: namePix.topAnchor, constant: 60),
            descriptionPix.leadingAnchor.constraint(equalTo: keyPixContainer.leadingAnchor, constant: 16),
            descriptionPix.trailingAnchor.constraint(equalTo: keyPixContainer.trailingAnchor, constant: -16),
            
            keyPixContainer.topAnchor.constraint(equalTo: dataPixContainer.bottomAnchor, constant: 20),
            keyPixContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            keyPixContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            keyPixContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            keyPixContainer.heightAnchor.constraint(equalToConstant: 150),
            
            titleCopyPastePix.topAnchor.constraint(equalTo: keyPixContainer.topAnchor, constant: 10),
            titleCopyPastePix.leadingAnchor.constraint(equalTo: keyPixContainer.leadingAnchor, constant: 16),
            titleCopyPastePix.trailingAnchor.constraint(equalTo: keyPixContainer.trailingAnchor, constant: -16),
            
            copyImage.centerYAnchor.constraint(equalTo: keyPixContainer.centerYAnchor),
            copyImage.trailingAnchor.constraint(equalTo: keyPixContainer.trailingAnchor, constant: -10),
            
            copyPastePix.topAnchor.constraint(equalTo: titleCopyPastePix.topAnchor, constant: 50),
            copyPastePix.leadingAnchor.constraint(equalTo: keyPixContainer.leadingAnchor, constant: 16),
            copyPastePix.trailingAnchor.constraint(equalTo: copyImage.leadingAnchor, constant: -10),
            
            qrcodePixContainer.topAnchor.constraint(equalTo: keyPixContainer.bottomAnchor, constant: 20),
            qrcodePixContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            qrcodePixContainer.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            qrcodePixContainer.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            qrcodePixContainer.heightAnchor.constraint(equalToConstant: 260),
            
            titleQrcodePix.topAnchor.constraint(equalTo: qrcodePixContainer.topAnchor, constant: 5),
            titleQrcodePix.leadingAnchor.constraint(equalTo: qrcodePixContainer.leadingAnchor, constant: 16),
            titleQrcodePix.trailingAnchor.constraint(equalTo: qrcodePixContainer.trailingAnchor, constant: -16),
            
            qrcodeImage.topAnchor.constraint(equalTo: titleQrcodePix.bottomAnchor),
            qrcodeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            qrcodeImage.heightAnchor.constraint(equalToConstant: 180),
            qrcodeImage.widthAnchor.constraint(equalToConstant: 180),
            
            keyPixLabel.bottomAnchor.constraint(equalTo: qrcodePixContainer.bottomAnchor, constant: -5),
            keyPixLabel.leadingAnchor.constraint(equalTo: qrcodePixContainer.leadingAnchor, constant: 10)
        ])
    }
    
}
