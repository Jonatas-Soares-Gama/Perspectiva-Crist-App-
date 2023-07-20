//
//  PodcastModel.swift
//  perspectiva Cristã
//
//  Created by Felipe Domingos on 17/06/23.
//

import Foundation

// MARK: Mock images of collectionView

struct Item {
    var image: String
    
}

class CollectionItemsMock {
    static let shared = CollectionItemsMock()
    
    func loadItems(completion: @escaping ([Item]) -> Void) {
        let items = [
            Item(image: "TriviumCast"),
            Item(image: "MissaodopovodeDeus"),
            Item(image: "masculinidadeemprosa"),
            Item(image: "grandesperguntas"),
            Item(image: "comoanalisaraliteratura"),
            Item(image: "entreaspas"),
            Item(image: "mascbiblica"),
            Item(image: "mulherespeidosas"),
            Item(image: "saude"),
            Item(image: "portugues"),
            Item(image: "sementes"),
            
        ]
        completion(items)
    }
}

// MARK: Model token of Spotify

struct Token: Codable {
    
    let token: String?
    let type: String?
    let expireTime: Int
    
    private enum CodingKeys: String, CodingKey {
        case token = "access_token"
        case type = "token_type"
        case expireTime = "expires_in"
    }
}

// MARK: Model playlists of Spotify

struct SpotifyPlaylistResponse: Codable {
    let playlist: SpotifyPlaylist
    let images: [Image]
    
    enum CodingKeys: String, CodingKey {
        case playlist = "tracks"
        case images
    }
}

struct Image: Codable {
    let url: String
}

struct SpotifyPlaylist: Codable {
    let items: [SpotifyTrack]
}

struct SpotifyTrack: Codable {
    let track: SpotifyTrackInfo
}

struct SpotifyTrackInfo: Codable {
    let id: String
    let name: String
    let artists: [SpotifyArtist]
    let album: SpotifyAlbum
    let durationMs: Int
    let previewUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artists
        case album
        case durationMs = "duration_ms"
        case previewUrl = "preview_url"
    }
}

struct SpotifyArtist: Codable {
    let id: String
    let name: String

}

struct SpotifyAlbum: Codable {
    let id: String
    let name: String
    let images: [SpotifyImage]
}

struct SpotifyImage: Codable {
    let url: String
    let width: Int
    let height: Int
}
