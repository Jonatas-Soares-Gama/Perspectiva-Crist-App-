//
//  HomeRadioController.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 04/03/23.
//

import Foundation
import UIKit

class HomeRadioController: UIViewController {
    
    var screen: RadioScreen?
    var service = Service()
    
    override func loadView() {
        screen = RadioScreen()
        view = screen
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension HomeRadioController: RadioProtocol {
    
    func actionPlayButton() {
        self.service.requestApi { station in
            self.screen?.playMusic(data: station)
        }
    }
    
    func actionPauseButton() {
        self.service.requestApi { station in
            self.screen?.pauseMusic(data: station)
        }
    }
    
    
}
