//
//  PodcastWebviewScreen.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 18/06/23.
//

import Foundation
import WebKit

class PodcastWebviewScreen: BaseView {
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    lazy var webView: WKWebView = {
        let web = WKWebView()
        web.translatesAutoresizingMaskIntoConstraints = false
        web.isHidden = true
        return web
    }()
    
    override func addSubviews() {
        addSubview(webView)
        addSubview(container)

    }
    
    override func setupConstrainst() {
        NSLayoutConstraint.activate([
            
            container.topAnchor.constraint(equalTo: topAnchor, constant: 330),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
