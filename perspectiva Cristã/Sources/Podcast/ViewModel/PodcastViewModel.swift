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
    private var screenTVR: PodcastImageRowCell?
    private var screenTVT: PodcastTitleRowCell?
    private var service: Service?
    var items = String()
    var imageSelfColors = UIImageView()
    
    init(vcp: PodcastTableViewController?, screen: PodcastTableViewScreen?, screenTV: PodcastTableViewCell?, screenTVR: PodcastImageRowCell?,screenTVT: PodcastTitleRowCell?, service: Service?) {
        self.vcp = vcp
        self.screen = screen
        self.screenTV = screenTV
        self.screenTVR = screenTVR
        self.screenTVT = screenTVT
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
    
    func effectFadeOut(scrollView: UIScrollView) {
        if let indexPath = screen?.tableView.indexPathsForVisibleRows?.first {
            // Obtém a célula correspondente
            let cell = screen?.tableView.cellForRow(at: indexPath)
            // Verifica se é a primeira linha (índice 0)
            if indexPath.row == 0 {
                // Calcula o fator de opacidade com base na posição da célula na tela
                let alpha = 1.0 - scrollView.contentOffset.y / (cell?.frame.height ?? 0)
                // Define a opacidade da célula
                cell?.alpha = alpha
            }
        }
    }
    
    func navigationTitleGrandList(data: UIScrollView) {
        let indexPath = IndexPath(row: 1, section: 0)
        let cellRect = screen?.tableView.rectForRow(at: indexPath)
        if let cellRect = cellRect {
            let cellPosition = screen?.tableView.convert(cellRect.origin, to: self.vcp?.view)
            let navigationBarHeight = self.vcp?.navigationController?.navigationBar.frame.height ?? 0
            if let vcp = vcp {
                for i in vcp.dataPlaylist {
                    let string = i.track.name
                    let separators = [" - ", "#", "|"]
                    var separatedString = string
                    
                    for separator in separators {
                        let components = separatedString.components(separatedBy: separator)
                        if let firstComponent = components.first {
                            separatedString = firstComponent.trimmingCharacters(in: .whitespacesAndNewlines)
                        }
                        if cellPosition?.y ?? 0 < navigationBarHeight {
                            vcp.navigationItem.title = "\(separatedString)"
                        } else if vcp.dataPlaylist.count <= 3 {
                            vcp.navigationItem.title = ""
                        } else {
                            vcp.navigationItem.title = ""
                        }
                    }
                }
            }
        }
    }
    
    
    func DataLabels(_ cell: PodcastTableViewCell, with episodeData: SpotifyTrack) {
        
        cell.titleLabel.text = episodeData.track.name
        for i in episodeData.track.artists {
            cell.subTitleLabel.text = i.name
        }
    }
    
    func firstRowTitle(_ cell: PodcastTitleRowCell, with episodeData: SpotifyTrack) {
        let string = episodeData.track.name
        let separators = [" - ", "#", "|"]
        var separatedString = string
        
        for separator in separators {
            let components = separatedString.components(separatedBy: separator)
            if let firstComponent = components.first {
                separatedString = firstComponent.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        cell.episodeTitle.text = "\(separatedString)"
    }
    
    
    func DataImage(_ cell: PodcastImageRowCell, PodCastwith episodeData: SpotifyTrack) {
        if let imgURL = URL(string: vcp?.imageData ?? "") {
            cell.episodeImage.sd_setImage(with: imgURL) { (image, _, _, _) in
            }
        }
    }
    
    func configureCallsTableViewInWebView(indexPath: IndexPath) {
        if indexPath.row <= 1 {
            
        } else {
            
            let episode = vcp?.dataPlaylist[indexPath.item - 2]
            if let selectedID = episode?.track.id {
                if #available(iOS 15.0, *) {
                    let vc = PodcastWebViewController(data: selectedID)
                    let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("myCustomDetent")) { [weak self] context in
                        guard let self = self else { return 0.0 }
                        return (self.vcp?.view.frame.height ?? 0) - 500.0
                    }
                    
                    if let sheet = vc.sheetPresentationController {
                        sheet.detents = [ customDetent ]
                    }
                    vcp?.navigationController?.present(vc, animated: true)
                }
            }
        }
    }
    
    func sizeOfRows(heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        } else if indexPath.row == 1 {
            return 50
        } else {
            return 90
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
