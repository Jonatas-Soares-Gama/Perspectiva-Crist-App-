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
        self.setViewControllers([screen01, screen02], animated: true)
        
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Rádio"
        items[0].image = UIImage(systemName: "dot.radiowaves.left.and.right")
        
        items[1].title = "Podcast"
        items[1].image = UIImage(systemName: "mic.fill")
    }
}




