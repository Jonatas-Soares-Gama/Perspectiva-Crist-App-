//
//  PodcastWebViewController.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 18/06/23.
//

import UIKit

class PodcastWebViewController: UIViewController {
    
    private let data: String
    init(data: String) {
        self.data = data
        super.init(nibName: "PodcastWebViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var screen = PodcastWebviewScreen()
    var viewModel: PodcastWebViewViewModel?

    override func loadView() {
        self.view = self.screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        viewModel?.initWebView(data: data)
        viewModel?.delayOfView()
    }
    
    private func initViewModel() {
        viewModel = PodcastWebViewViewModel(screen: screen, vc: self)
    }
}
