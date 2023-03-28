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
        
        let tela01 = UINavigationController(rootViewController: RadioController())
        let tela02 = UINavigationController(rootViewController: LibraryController())
        self.setViewControllers([tela01, tela02], animated: true)
        
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Rádio"
        items[0].image = UIImage(systemName: "dot.radiowaves.left.and.right")
        
        items[1].title = "Biblioteca"
        items[1].image = UIImage(systemName: "books.vertical.fill")
    }
    
    class RadioController: UIViewController {
        
        var screen: RadioScreen?
        var audioPlayer: AVAudioPlayer?
        var service = Service()
        
        override func loadView() {
            screen = RadioScreen()
            view = screen
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            self.service.requestApi { station in
                print(station)
            }
            setupMediaButton()
            
        }
        override func viewWillAppear(_ animated: Bool) {
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
        @objc func actionPlayButton() {
            screen?.playButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            
            

        }
        func setupMediaButton() {
            screen?.didTapButtonPlayButton(target: self, action: #selector(actionPlayButton))
        }
        
    }
        
        class LibraryController: UIViewController {
            
            var screen: LibraryScreen?
            
            override func loadView() {
                screen = LibraryScreen()
                view = screen
            }
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
            }
            
            override func viewWillAppear(_ animated: Bool) {
                navigationController?.setNavigationBarHidden(true, animated: false)
            }
            
        }
        
    }

