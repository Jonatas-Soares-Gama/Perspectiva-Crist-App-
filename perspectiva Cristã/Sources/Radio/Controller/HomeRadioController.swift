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
    var viewModel: RadioViewModel?
    
    override func loadView() {
        screen = RadioScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        viewModel?.populateViewModel()
    }
    
    
    private func initViewModel() {
        viewModel = RadioViewModel(screen: screen)
    }
}
