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
    
    private var vcp: PodcastCollectionController?
    private var screen:  PodcastScreen?
    private var viewCell: PodcastCollectionViewCell?
    private var service: Service?
    var timer = Timer()
    var items: [Item] = []

    
    init(vcp: PodcastCollectionController?, screen: PodcastScreen?, viewCell: PodcastCollectionViewCell?, service: Service?) {
        self.vcp = vcp
        self.screen = screen
        self.viewCell = viewCell
        self.service = service
    }
    
    func addData() {
        CollectionItemsMock.shared.loadItems { items in
            self.items = items
        }
    }
    
        func collectionViewContent(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PodcastCollectionViewCell.identifier , for: indexPath) as! PodcastCollectionViewCell
        let item = items[indexPath.item]
        cell.logoImage.image = UIImage(named: item.image)
        return cell
    }
    
    func spacingOfCollectionsView(collectionView: UICollectionView)  -> CGSize {
        let spacing: CGFloat = 10.0
        let width = (collectionView.bounds.width - spacing * 3) / 1.9555
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func timerTobearerToken(bearer: Token) {
        var remainingTime = bearer.expireTime
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if remainingTime > 0 {
                remainingTime -= 1
                //                print("Tempo restante: \(remainingTime)")
            } else if remainingTime == 0 {
                self.service?.requestSpotifyToken{ token in
                    self.timerTobearerToken(bearer: token)
                }
            }
        }
    }
}
