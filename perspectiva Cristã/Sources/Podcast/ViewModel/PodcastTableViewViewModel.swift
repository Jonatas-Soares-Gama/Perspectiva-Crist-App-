//
//  PodcastTableViewModel.swift
//  perspectiva Cristã
//
//  Created by Felipe Henrique Domingos on 26/07/23.
//

import Foundation
import UIKit
import HPParallaxHeader

class PodcastTableViewViewModel {
    
    private var vcp: PodcastTableViewController?
    private var screen:  PodcastTableViewScreen?
    private var screenTV: PodcastTableViewCell?
    private var screenTVR: PodcastFirstRowCell?
    private var customHeader: CustomHeaderView?
    private var service: Service?
    private var items = String()
    private var dataPlaylist: [SpotifyTrack] = []
    private var imageData = String()
    
    init(vcp: PodcastTableViewController?, screen: PodcastTableViewScreen?, screenTV: PodcastTableViewCell?, screenTVR: PodcastFirstRowCell?, customHeader: CustomHeaderView?, service: Service?) {
        self.vcp = vcp
        self.screen = screen
        self.screenTV = screenTV
        self.screenTVR = screenTVR
        self.service = service
        self.customHeader = customHeader
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
    
    private func setTransparentNavigationBar() {
        vcp?.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        vcp?.navigationController?.navigationBar.shadowImage = UIImage()
        vcp?.navigationController?.navigationBar.backgroundColor = .clear
        vcp?.navigationController?.navigationBar.tintColor = .white
        vcp?.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        vcp?.navigationItem.title = ""
    }
    
    private func tratamentImageOfNavigationBar() {
        let image = UIImageView()
        if let imgURL = URL(string: imageData ) {
            image.sd_setImage(with: imgURL) { (image, _, _, _) in
                self.vcp?.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
                self.vcp?.navigationController?.navigationBar.shadowImage = image
            }
        }
    }
    
    private func setNotTransparentNavigationBar() {
        tratamentImageOfNavigationBar()
        vcp?.navigationController?.navigationBar.shadowImage = nil
        vcp?.navigationController?.navigationBar.tintColor = .white
        vcp?.navigationController?.navigationBar.isTranslucent = true
        vcp?.navigationController?.navigationBar.backItem?.title = ""
    }
    
    
    func navigationBarTitle(scrollView: UIScrollView) {
        let indexPath = IndexPath(row: 0, section: 0)
        let cellRect = screen?.tableView.rectForRow(at: indexPath)
        if let cellRect = cellRect {
            let cellPosition = screen?.tableView.convert(cellRect.origin, to: self.vcp?.view)
            let navigationBarHeight = self.vcp?.navigationController?.navigationBar.frame.height ?? 0
            if cellPosition?.y ?? 0 <= navigationBarHeight {
                setNotTransparentNavigationBar()
                separetedString()
            } else if dataPlaylist.count <= 3 {
                setTransparentNavigationBar()
            } else {
                setTransparentNavigationBar()
            }
        }
    }
    
    private func separetedString() {
        for name in dataPlaylist {
            let string = name.track.name
            let separators = [" - ", "#", "|"]
            var separatedString = string
            for separator in separators {
                let components = separatedString.components(separatedBy: separator)
                if let firstComponent = components.first {
                    separatedString = firstComponent.trimmingCharacters(in: .whitespacesAndNewlines)
                }
                vcp?.navigationItem.title = "\(separatedString)"
            }
        }
    }
    
    private func backButton() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backAction))
        backButton.image = UIImage(systemName: "chevron.backward")
        vcp?.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backAction() {
        vcp?.navigationController?.popViewController(animated: true)
    }
    
    func populateViewModel() {
        callToCustomHeaderTableView()
        backButton()
        service?.requestSpotifyApi(ids: items) { episodes in
            self.dataToTableView(data: episodes)
            self.dataImage()
        }
    }
    
    private func callToCustomHeaderTableView() {
        customHeader = CustomHeaderView()
        screen?.tableView.parallaxHeader.view = customHeader
        screen?.tableView.parallaxHeader.height = 450
        screen?.tableView.parallaxHeader.mode = .topFill
        screen?.tableView.parallaxHeader.minimumHeight = 90
    }
    
    private func dataImage() {
        if let imgURL = URL(string: imageData) {
            customHeader?.episodeImage.sd_setImage(with: imgURL) { (image, _, _, _) in
                image?.getColors() { colors in
                    self.screen?.tableView.parallaxHeader.view?.backgroundColor = colors?.primary
                }
            }
        }
    }
    
    private func dataToTableView(data: SpotifyPlaylistResponse) {
        self.dataPlaylist.append(contentsOf: data.playlist.items)
        for img in data.images {
            imageData = img.url
        }
        screen?.tableView.reloadData()
    }
    
    private func firstRowTitle(_ cell: PodcastFirstRowCell, with episodeData: SpotifyTrack) {
        let string = episodeData.track.name
        let separators = [" - ", "#", "|"]
        var separatedString = string
        
        for separator in separators {
            let components = separatedString.components(separatedBy: separator)
            if let firstComponent = components.first {
                separatedString = firstComponent.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        cell.titleLabel.text = "\(separatedString)"
        cell.episodesCountLabel.text = "\(dataPlaylist.count) Episódios"
    }
    
    private func episodeDurationCount(_ cell: PodcastTableViewCell, with episodeData: SpotifyTrack) {
        let milliseconds = episodeData.track.durationMs
        let minutes = 60000
        let result = (milliseconds / minutes)
        cell.episodesDuration.text = "Duração: \(result)min"
    }
    
    private func dataRows(_ cell: PodcastTableViewCell, with episodeData: SpotifyTrack) {
        cell.titleLabel.text = episodeData.track.name
        for episodesNames in episodeData.track.artists {
            cell.subTitleLabel.text = episodesNames.name
            if let imgURL = URL(string: imageData) {
                cell.episodeImage.sd_setImage(with: imgURL) { (image, _, _, _) in
                }
            }
            episodeDurationCount(cell, with: episodeData)
        }
    }
    
    func countOfRows(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPlaylist.count + 1
    }
    
    func tableViewContent(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PodcastFirstRowCell.identifier, for: indexPath) as! PodcastFirstRowCell
            if dataPlaylist.count > 0 {
                let titleData = dataPlaylist[0]
                firstRowTitle(cell, with: titleData)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PodcastTableViewCell.identifier, for: indexPath) as! PodcastTableViewCell
            let episodeIndex = indexPath.row
            let episodeData = dataPlaylist[episodeIndex - 1]
            dataRows(cell, with: episodeData)
            
            return cell
        }
    }
    
    func sizeOfRows(indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        } else {
            return 120
        }
    }
    
    func separatorLine(cell: UITableViewCell, indexPath: IndexPath) {
        if indexPath.row == 0 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width, bottom: 0, right: 0)
            screen?.tableView.separatorColor = .lightGray
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
            screen?.tableView.separatorColor = .lightGray
        }
    }
    
    func configureCallsTableViewInWebView(indexPath: IndexPath) {
        if indexPath.row == 0 {
        } else {
            let episode = dataPlaylist[indexPath.item - 1]
            if #available(iOS 15.0, *) {
                let vc = PodcastWebViewController(data: episode.track.id)
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
