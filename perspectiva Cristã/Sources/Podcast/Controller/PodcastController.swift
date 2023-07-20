//
//  PodcastControllerViewController.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 05/06/23.
//

import UIKit
import WebKit

class PodcastController: UIViewController {
    
    private var screen = PodcastScreen()
    private var service = Service()
    private var viewModel: PodcastViewModel?
    var items: [Item] = []
    
    override func loadView() {
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addData()
        initViewModel()
        self.screen.configCollectionViewProtocols(delegate: self, dataSource: self)
        view.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
        service.requestSpotifyToken { token in
            self.viewModel?.timerTobearerToken(bearer: token)
        }
    }
    
    func addData() {
        CollectionItemsMock.shared.loadItems { items in
            self.items = items
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func initViewModel() {
        viewModel = PodcastViewModel(vcp: self, screen: screen, service: service)
    }
}

extension PodcastController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screen.identifier, for: indexPath) as! PodcastCollectionViewCell
        let item = items[indexPath.item]
        cell.logoImage.image = UIImage(named: item.image)
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
