//
//  DonationController.swift
//  perspectiva Cristã
//
//  Created by Jonatas Gama on 27/06/23.
//

import UIKit

class DonationController: UIViewController {
    
    private var screen = DonationScreen()
    private var viewModel: DonationViewModel?
    
    override func loadView() {
        screen = DonationScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        viewModel?.copyGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func initViewModel() {
        viewModel = DonationViewModel(screen: screen)
    }
}


