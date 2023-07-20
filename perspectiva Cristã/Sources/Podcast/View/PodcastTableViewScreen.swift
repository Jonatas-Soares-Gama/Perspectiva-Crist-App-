//
//  PodcastTableViewScreen.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 25/06/23.
//

import Foundation
import UIKit

class PodcastTableViewScreen: BaseView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(PodcastTableViewCell.self, forCellReuseIdentifier: PodcastTableViewCell.identifier)
        tableView.register(PodcastFirstRowCell.self, forCellReuseIdentifier: PodcastFirstRowCell.identifier)
        tableView.separatorStyle = .singleLine
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

