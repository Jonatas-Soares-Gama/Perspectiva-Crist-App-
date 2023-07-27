//
//  PodcastTableViewController.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 25/06/23.
//

import UIKit
import SDWebImage

class PodcastTableViewController: UIViewController, UIViewControllerTransitioningDelegate, UIScrollViewDelegate {
    
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
    private var screenTVR: PodcastFirstRowCell?
    private var viewModel: PodcastTableViewViewModel?
    private var service = Service()
    var isFloating = false

    
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen.configTableViewProtocols(delegate: self, dataSource: self)
        initViewModel()
        viewModel?.initCollectionItens(with: data)
        viewModel?.populateViewModel()
        viewModel?.backButton()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func initViewModel() {
        viewModel = PodcastTableViewViewModel(vcp: self, screen: screen, screenTV: screenTV, screenTVR: screenTVR, service: service)
    }
}

extension PodcastTableViewController: UITableViewDataSource, UITableViewDelegate {
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewModel?.navigationBarTitle(scrollView: scrollView)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel?.separatorLine(cell: cell, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel?.countOfRows(tableView, numberOfRowsInSection: section) else  { return Int() }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = viewModel?.tableViewContent(indexPath: indexPath)  else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.configureCallsTableViewInWebView(indexPath: indexPath)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let size = viewModel?.sizeOfRows(indexPath: indexPath) else  { return CGFloat() }
        return size
    }
}
