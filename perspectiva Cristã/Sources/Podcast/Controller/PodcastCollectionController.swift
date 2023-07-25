//
//  PodcastControllerViewController.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 05/06/23.
//

import UIKit
import WebKit

class PodcastCollectionController: UIViewController {
    
    private var screen = PodcastScreen()
    private var service = Service()
    private var viewModel: PodcastViewModel?
    private var viewCell: PodcastCollectionViewCell?
    
    override func loadView() {
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        self.screen.configCollectionViewProtocols(delegate: self, dataSource: self)
        view.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
        service.requestSpotifyToken { token in
            self.viewModel?.timerTobearerToken(bearer: token)
        }
        viewModel?.addData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func initViewModel() {
        viewModel = PodcastViewModel(vcp: self, screen: screen, viewCell: viewCell, service: service)
    }
}

extension PodcastCollectionController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = viewModel?.collectionViewContent(collectionView: collectionView, indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10.0
        let width = (collectionView.bounds.width - spacing * 3) / 1.9555
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PodcastTableViewController(data: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
}
