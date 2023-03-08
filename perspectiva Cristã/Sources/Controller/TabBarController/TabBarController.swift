//
//  TabBarControllerViewController.swift
//  perspectiva Cristã
//
//  Created by Jonatas Gama on 25/02/23.
//

import UIKit
import AVFoundation

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        
        let screen01 = UINavigationController(rootViewController: HomeRadioController())
        let screen02 = UINavigationController(rootViewController: PodcastController())
        let screen03 = UINavigationController(rootViewController: FavoritController())
        let screen04 = UINavigationController(rootViewController: CultsController())
        self.setViewControllers([screen01, screen02, screen03, screen04], animated: true)
        
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Rádio"
        items[0].image = UIImage(systemName: "dot.radiowaves.left.and.right")
        
        items[1].title = "Podcast"
        items[1].image = UIImage(systemName: "mic.fill")
        
        items[2].title = "Favoritos"
        items[2].image = UIImage(systemName: "heart")
        
        items[3].title = "Cultos"
        items[3].image = UIImage(systemName: "house")
    }
}




