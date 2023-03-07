//
//  PodcastController.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 04/03/23.
//

import Foundation
import UIKit

class PodcastController: UIViewController {
    
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
