//
//  Model.swift
//  perspectiva Cristã
//
//  Created by Jonatas Gama on 27/02/23.
//

import Foundation

struct List: Codable {
    let station: Station?
    let nowPlaying: NowPlaying?
    
    private enum CodingKeys: String, CodingKey {
        case station
        case nowPlaying = "now_playing"
    }
}

struct Station: Codable {
    let listenURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case listenURL = "listen_url"
    }
}

struct NowPlaying: Codable {
    let song: Song?
}

struct Song: Codable {
    let artist: String?
    let title: String?
    let art: String?
}



