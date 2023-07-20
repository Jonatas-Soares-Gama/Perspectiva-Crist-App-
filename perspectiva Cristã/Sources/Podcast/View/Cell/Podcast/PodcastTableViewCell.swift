//
//  PodcastTableViewCell.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 20/06/23.
//

//
//  HabilitiesTableViewCell.swift
//  PokedexViewCode
//
//  Created by Felipe Domingos on 19/12/22.
//

import UIKit
import WebKit

class PodcastTableViewCell: BaseTableViewCell {

    static let indentifier: String = "PodcastTableViewCell"
    
    lazy var podcastCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var webView: WKWebView = {
        let web = WKWebView()
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()
    
    override func addSubViews() {
        addSubview(podcastCell)
        podcastCell.addSubview(webView)
    }
    
    override func setUpConstraints() {
        NSLayoutConstraint.activate([
            podcastCell.topAnchor.constraint(equalTo: topAnchor),
            podcastCell.leadingAnchor.constraint(equalTo: leadingAnchor),
            podcastCell.trailingAnchor.constraint(equalTo: trailingAnchor),
            podcastCell.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ])
    }
}

