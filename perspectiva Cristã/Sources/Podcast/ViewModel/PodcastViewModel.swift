//
//  PodcastViewModel.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 18/06/23.
//

import Foundation
import WebKit
import UIKit
import SDWebImage

class PodcastViewModel {
    
    private var vcp: PodcastController?
    private var screen:  PodcastScreen?
    private var service: Service?
    var timer = Timer()
    
    init(vcp: PodcastController?, screen: PodcastScreen?, service: Service?) {
        self.vcp = vcp
        self.screen = screen
        self.service = service
    }
    
    
    func timerTobearerToken(bearer: Token) {
        var remainingTime = bearer.expireTime
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if remainingTime > 0 {
                remainingTime -= 1
                print("Tempo restante: \(remainingTime)")
            } else if remainingTime == 0 {
                self.service?.requestSpotifyToken{ token in
                    self.timerTobearerToken(bearer: token)
                }
            }
        }
    }
}

class PodcastTableViewViewModel {
    
    private var vcp: PodcastTableViewController?
    private var screen:  PodcastTableViewScreen?
    private var screenTV: PodcastTableViewCell?
    private var screenTVR: PodcastFirstRowCell?
    private var service: Service?
    var items = String()
    
    
    init(vcp: PodcastTableViewController?, screen: PodcastTableViewScreen?, screenTV: PodcastTableViewCell?, screenTVR: PodcastFirstRowCell?, service: Service?) {
        self.vcp = vcp
        self.screen = screen
        self.screenTV = screenTV
        self.screenTVR = screenTVR
        self.service = service
    }
    
    func initCollectionItens(with choice: Int) {
        
        switch choice {
        case 0:
            items = "5I9xtxN65z8pAEawlpohnD"
        case 1:
            items = "5fP7BnXYk6ArBFRX6RobTC"
        case 2:
            items = "2uH7425MVaicP4HTwFj6TH"
        case 3:
            items = "7hXqTs1S0lhfmwbmk2x9Ji"
        case 4:
            items = "7JxngU2TjCEvYlEJ295c4w"
        case 5:
            items = "7fZ3TV61qH0DQ6OMPbkeNA"
        case 6:
            items = "1PWTBv3QGUGQLupKdco7nB"
        case 7:
            items = "1LmkPNmiwZ6FnGICEZHt4k"
        case 8:
            items = "0SjOpbFH82z90QXp2MhohT"
        case 9:
            items = "1k0PDsvLM6y86A5XrrJzSb"
        case 10:
            items = "5yUFW5ptTiSLySl2EkHRh9"
        default:
            items = ""
        }
    }
    
    func navigationBarTitle(_ cell: PodcastTableViewCell, with episodeData: SpotifyTrack) {
        let string = episodeData.track.name
        let separators = [" - ", "#", "|"]
        var separatedString = string
        
        for separator in separators {
            let components = separatedString.components(separatedBy: separator)
            if let firstComponent = components.first {
                separatedString = firstComponent.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        vcp?.navigationItem.title = "Podcast: \(separatedString)"
    }
    
    func DataLabels(_ cell: PodcastTableViewCell, with episodeData: SpotifyTrack) {
        let string = episodeData.track.name
        
        let separators = [" - ", "#", "|"]
        var excludedString = string
        
        for separator in separators {
            let components = excludedString.components(separatedBy: separator)
            if let firstComponent = components.first {
                excludedString = firstComponent.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        if let range = string.range(of: "\(excludedString)") {
            let index = range.upperBound
            let trimmedString = String(string[index...])
            
            // Separar pelo "|", "-" ou "#"
            let separators = [" | ", " - ", "#"]
            var separatedStringLabel: [String]? = nil
            
            for separator in separators {
                separatedStringLabel = trimmedString.components(separatedBy: separator)
                if separatedStringLabel?.count ?? 0 > 1 {
                    break
                }
            }
            
            if let components = separatedStringLabel {
                if let firstLabelValue = components.first?.trimmingCharacters(in: .whitespacesAndNewlines) {
                    cell.titleLabel.text = "\(firstLabelValue):"
                    if cell.titleLabel.text?.count ?? 0 < 4 {
                        cell.titleLabel.text = "Episódio: \(firstLabelValue)"
                    } else {
                        if let range = string.range(of: " - ") {
                            let index = range.upperBound
                            let trimmedString = String(string[index...])
                            
                            // Separar pelo "|", "-" ou "#"
                            let separators = [" | ", " - ", "#"]
                            var separatedStringLabel: [String]? = nil
                            
                            for separator in separators {
                                separatedStringLabel = trimmedString.components(separatedBy: separator)
                                if separatedStringLabel?.count ?? 0 > 1 {
                                    break
                                }
                            }
                            
                            if let components = separatedStringLabel {
                                if let firstLabelValue = components.first?.trimmingCharacters(in: .whitespacesAndNewlines) {
                                    cell.titleLabel.text = "\(firstLabelValue):"
                                }
                            }
                        }
                    }
                }
                
                if let secondLabelValue = components.last?.trimmingCharacters(in: .whitespacesAndNewlines) {
                    cell.subTitleLabel.text = secondLabelValue
                }
            }
        }
    }
    
    func firstRowTitle(_ cell: PodcastFirstRowCell, with episodeData: SpotifyTrack) {
        let string = episodeData.track.name
        let separators = [" - ", "#", "|"]
        var separatedString = string
        
        for separator in separators {
            let components = separatedString.components(separatedBy: separator)
            if let firstComponent = components.first {
                separatedString = firstComponent.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        screenTVR?.episodeTitle.text = "Podcast: \(separatedString)"
    }

    
    func DataImage(_ cell: PodcastFirstRowCell, PodCastwith episodeData: SpotifyTrack) {
        if let imgURL = URL(string: vcp?.imageData ?? "") {
            cell.episodeImage.sd_setImage(with: imgURL) { (image, _, _, _) in
                image?.getColors { colors in
                    cell.container.backgroundColor = colors?.secondary
                    cell.episodeTitle.textColor = colors?.primary
                    self.screen?.tableView.separatorColor = colors?.background
                    self.screen?.tableView.backgroundColor = colors?.secondary
                }
            }
        }
    }
}

class PodcastWebViewviewModel {
    
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
