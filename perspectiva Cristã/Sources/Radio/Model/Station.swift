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
    let playingNext: PlayingNext?
    
    private enum CodingKeys: String, CodingKey {
        case station
        case nowPlaying = "now_playing"
        case playingNext = "playing_next"
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
    let duration: Int
    let remaining: Int
}

struct Song: Codable {
    let artist: String?
    let title: String?
    let art: String?
}

struct PlayingNext: Codable {
    let song2: Song2?
    let duration: Int

    private enum CodingKeys: String, CodingKey {
        case song2 = "song"
        case duration
    }
}

struct Song2: Codable {
    let artist: String?
    let title: String?
    let art: String?
}

