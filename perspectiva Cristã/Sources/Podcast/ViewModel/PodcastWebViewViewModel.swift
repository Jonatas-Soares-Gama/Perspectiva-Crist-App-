//
//  PodcastWebViewViewModel.swift
//  perspectiva Cristã
//
//  Created by Felipe Henrique Domingos on 26/07/23.
//

import Foundation

class PodcastWebViewViewModel {
    
    let screen: PodcastWebviewScreen?
    let vc: PodcastWebViewController?
    
    init(screen: PodcastWebviewScreen?, vc: PodcastWebViewController?) {
        self.screen = screen
        self.vc = vc
    }
    
    func initWebView(data: String) {
        DispatchQueue.main.async {
            if let url = URL(string: "https://open.spotify.com/embed/episode/\(data)?utm_source=generator&theme=0") {
                let request = URLRequest(url: url)
                self.screen?.webView.load(request)
            }
        }
    }
    
    func delayOfView() {
        let delayInSeconds: Double = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
            self.screen?.container.isHidden = false
            self.screen?.webView.isHidden = false
        }
    }
}

