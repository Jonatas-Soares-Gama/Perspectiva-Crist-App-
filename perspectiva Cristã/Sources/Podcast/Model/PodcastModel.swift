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
    var name: String
    
}

class CollectionItemsMock {
    static let shared = CollectionItemsMock()
    
    func loadItems(completion: @escaping ([Item]) -> Void) {
        let items = [
            Item(image: "TriviumCast", name: "5I9xtxN65z8pAEawlpohnD"),
            Item(image: "MissaodopovodeDeus", name: "5fP7BnXYk6ArBFRX6RobTC"),
            Item(image: "masculinidadeemprosa", name: "2uH7425MVaicP4HTwFj6TH"),
            Item(image: "grandesperguntas", name: "7hXqTs1S0lhfmwbmk2x9Ji"),
            Item(image: "comoanalisaraliteratura", name: "7JxngU2TjCEvYlEJ295c4w"),
            Item(image: "entreaspas", name: "7fZ3TV61qH0DQ6OMPbkeNA"),
            Item(image: "mascbiblica", name: "1PWTBv3QGUGQLupKdco7nB"),
            Item(image: "mulheres", name: "1LmkPNmiwZ6FnGICEZHt4k"),
            Item(image: "saude", name: "0SjOpbFH82z90QXp2MhohT"),
            Item(image: "portugues", name: "1k0PDsvLM6y86A5XrrJzSb"),
            Item(image: "sementes", name: "5yUFW5ptTiSLySl2EkHRh9"),
            
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
