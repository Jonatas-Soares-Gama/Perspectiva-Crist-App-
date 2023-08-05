//
//  DonationController.swift
//  perspectiva Cristã
//
//  Created by Jonatas Gama on 27/06/23.
//

import UIKit

class DonationController: UIViewController {
    
    private var screen: DonationScreen?
    
    override func loadView() {
        screen = DonationScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
}


