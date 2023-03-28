//
//  Model.swift
//  perspectiva Cristã
//
//  Created by Jonatas Gama on 27/02/23.
//

import Foundation


// MARK: - Station
struct Station: Codable {
    
    let listenURL: String?
    
    enum CodinKeys: String, CodingKey {
        case listenURL = "listen_url"
    }
}






//    let id: Int?
//    let name, shortcode, description, frontend: String?
//    let backend: String?
//    let listenURL: String?
//    let url: String?
//    let publicPlayerURL: String?
//    let playlistPlsURL: String?
//    let playlistM3UURL: String?
//    let isPublic: Bo, ol?
//    let mounts: [Mount]?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, shortcode, description, frontend, backend
//        case listenURL = "listen_url"
//        case url
//        case publicPlayerURL = "public_player_url"
//        case playlistPlsURL = "playlist_pls_url"
//        case playlistM3UURL = "playlist_m3u_url"
//        case isPublic = "is_public"
//        case mounts
//    }
//}
//
//// MARK: - Mount
//struct Mount: Codable {
//    let id: Int
//    let name: String
//    let url: String
//    let bitrate: Int
//    let format: String
//    let listeners: Listeners
//    let path: String
//    let isDefault: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, url, bitrate, format, listeners, path
//        case isDefault = "is_default"
//    }
//
//}
//
//// MARK: - Listeners
//struct Listeners: Codable {
//    let total, unique, current: Int






