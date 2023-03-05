//
//  Model.swift
//  perspectiva Cristã
//
//  Created by Jonatas Gama on 27/02/23.
//

import Foundation


// MARK: - Station
struct List: Codable {
    let station: Station?
}

struct Station: Codable {
    let id: Int?
    let listenURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case listenURL = "listen_url"
    }
}




