//
//  PodcastTableViewController.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 25/06/23.
//

import UIKit
import SDWebImage

class PodcastTableViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    private let data: Int
    init(data: Int) {
        self.data = data
        super.init(nibName: "PodcastTableViewController", bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var screen = PodcastTableViewScreen()
    private var viewModel: PodcastTableViewViewModel?
    private var service = Service()
    private var screenTV = PodcastTableViewCell()
    private var screenTVR: PodcastFirstRowCell?
    private var screenTVT: PodcastTitleRowCell?
    var selectedID: String?
    var imageData = String()
    var dataPlaylist: [SpotifyTrack] = []
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
        screen.configTableViewProtocols(delegate: self, dataSource: self)
        initViewModel()
        viewModel?.initCollectionItens(with: data)
        populateViewModel()
    }
    
    func populateViewModel() {
        if let items = viewModel?.items {
            service.requestSpotifyApi(ids: items) { episodes in
                self.dataToTableView(data: episodes)
            }
        }
    }
    
    func dataToTableView(data: SpotifyPlaylistResponse) {
        self.dataPlaylist.append(contentsOf: data.playlist.items)
        for img in data.images {
            imageData = img.url
        }
        screen.tableView.reloadData()
    }
    
    private func initViewModel() {
viewModel = PodcastTableViewViewModel(vcp: self, screen: screen, screenTV: screenTV, screenTVR: screenTVR, screenTVT: screenTVT, service: service)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension PodcastTableViewController: UITableViewDataSource, UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPlaylist.count + 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PodcastFirstRowCell.identifier, for: indexPath) as! PodcastFirstRowCell
            if dataPlaylist.count > 0 {
                let titleData = dataPlaylist[0]
                viewModel?.DataImage(cell, PodCastwith: titleData)
            }
            return cell
        } else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: PodcastTitleRowCell.identifier, for: indexPath) as! PodcastTitleRowCell
                if dataPlaylist.count > 1 {
                    let titleData = dataPlaylist[1]
                    viewModel?.firstRowTitle(cell, with: titleData)
                }
                return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PodcastTableViewCell.identifier, for: indexPath) as! PodcastTableViewCell
            let episodeIndex = indexPath.row - 2
            if episodeIndex < dataPlaylist.count {
                let episodeData = dataPlaylist[episodeIndex]
                viewModel?.DataLabels(cell, with: episodeData)
                viewModel?.navigationBarTitle(cell, with: episodeData)
            }
            return cell
        }
    }
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row <= 1 {
        
    } else {

        let episode = dataPlaylist[indexPath.item - 2]
        let selectedID = episode.track.id
        if #available(iOS 15.0, *) {
            let vc = PodcastWebViewController(data: selectedID)
            let customDetent = UISheetPresentationController.Detent.custom(identifier: .init("myCustomDetent")) { [weak self] context in
                guard let self = self else { return 0.0 }
                return self.view.frame.height - 500.0
            }
            
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [ customDetent ]
            }
            navigationController?.present(vc, animated: true)
        }
    }
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row <= 0 {
        return 350
    } else {
        return 120
    }
}
}
