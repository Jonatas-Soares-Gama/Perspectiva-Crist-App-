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
    private var screenTV = PodcastTableViewCell()
    private var screenTVR: PodcastImageRowCell?
    private var screenTVT: PodcastTitleRowCell?
    private var viewModel: PodcastTableViewViewModel?
    private var service = Service()
    
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
        screen.configTableViewProtocols(delegate: self, dataSource: self)
        initViewModel()
        viewModel?.initCollectionItens(with: data)
        viewModel?.populateViewModel()
        navigationController?.navigationBar.barTintColor = .clear
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
    }
    
    private func initViewModel() {
        viewModel = PodcastTableViewViewModel(vcp: self, screen: screen, screenTV: screenTV, screenTVR: screenTVR, screenTVT: screenTVT, service: service)
    }
}

extension PodcastTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewModel?.navigationTitleGrandList(data: scrollView)
        viewModel?.effectFadeOut(scrollView: scrollView)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel?.separatorLine(cell: cell, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.dataPlaylist.count ?? 0) + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PodcastImageRowCell.identifier, for: indexPath) as! PodcastImageRowCell
            if viewModel?.dataPlaylist.count ?? 0 > 0 {
                if let titleData = viewModel?.dataPlaylist[0] {
                    viewModel?.DataImage(cell, PodCastwith: titleData)
                }
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PodcastTitleRowCell.identifier, for: indexPath) as! PodcastTitleRowCell
            if viewModel?.dataPlaylist.count ?? 0 > 1 {
                if let titleData = viewModel?.dataPlaylist[1]  {
                    viewModel?.firstRowTitle(cell, with: titleData)
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PodcastTableViewCell.identifier, for: indexPath) as! PodcastTableViewCell
            let episodeIndex = indexPath.row - 2
            if episodeIndex < viewModel?.dataPlaylist.count ?? 0 {
                if let episodeData = viewModel?.dataPlaylist[episodeIndex] {
                    viewModel?.DataLabels(cell, with: episodeData)
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.configureCallsTableViewInWebView(indexPath: indexPath)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel?.sizeOfRows(indexPath: indexPath) ?? 0
    }
}
