//
//  PodcastTableViewScreen.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 25/06/23.
//

import Foundation
import UIKit

class PodcastTableViewScreen: BaseView {
    
    var backButton: UIBarButtonItem?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(red: 23/255, green: 78/255, blue: 155/255, alpha: 1.0)
        tableView.register(PodcastTableViewCell.self, forCellReuseIdentifier: PodcastTableViewCell.identifier)
        tableView.register(PodcastImageRowCell.self, forCellReuseIdentifier: PodcastImageRowCell.identifier)
        tableView.register(PodcastTitleRowCell.self, forCellReuseIdentifier: PodcastTitleRowCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        return tableView
    }()
    
    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    override func addSubviews() {
        addSubview(tableView)
    }
    
    override func setupConstrainst() {
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    
}

