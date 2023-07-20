//
//  TabViewController.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 05/06/23.


import Foundation

import UIKit

class TabBarController: UITabBarController {
    
    var screen: RadioScreen?
    var viewModel: RadioViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        
        let screen01 = UINavigationController(rootViewController: HomeRadioController())
        let screen02 = UINavigationController(rootViewController: PodcastController())
        let screen03 = UINavigationController(rootViewController: DonationController())
        self.setViewControllers([screen01, screen02, screen03], animated: true)
        
        tabBar.backgroundColor = .systemGray
        tabBar.isTranslucent = true
        
        guard let items = tabBar.items else { return }
            
        items[0].title = "Rádio"
        items[0].image = UIImage(systemName: "radio.fill")
        
        items[1].title = "Podcast" 
        items[1].image = UIImage(systemName: "mic.fill")
        
        items[2].title = "Doação"
        items[2].image = UIImage(systemName: "heart.fill")
        
    }
    private func initViewModel() {
        if let screen = self.screen {
            viewModel = RadioViewModel(screenView: screen)
        }
    }
}
