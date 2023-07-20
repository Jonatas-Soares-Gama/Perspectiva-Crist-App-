//
//  Service.swift
//  perspectiva Cristã
//
//  Created by Jonatas Gama on 28/02/23.
//

import Foundation
import Alamofire

class Service {
    
    func requestApi(completion: @escaping(_ station: List) -> Void) {
        let baseUrl = "https://s09.w3bserver.com/api/nowplaying_static/perspectiva_crista.json"
        
        AF.request(baseUrl, method: .get).response { response in
            if let data = response.data {
                let decoder = JSONDecoder()
                guard let stationDecoder = try? decoder.decode(List.self, from: data) else { return }
                completion(stationDecoder)
            }
        }
    }
    
    func requestSpotifyApi(ids: String, completion: @escaping(_ episodes: SpotifyPlaylistResponse) -> Void) {
        
        let baseUrl = "https://api.spotify.com/v1/playlists"
        let bearer = "\(UserDefaults.standard.string(forKey: "someObject") ?? "")"
        let parameters: Parameters = ["market": "PT"]
        let headers: HTTPHeaders = ["Authorization": "Bearer \(bearer)"]
        
        AF.request("\(baseUrl)/\(ids)", method: .get, parameters: parameters, headers: headers).response { response in
            if let data = response.data {
                if response.response?.statusCode == 200 {
                    let decoder = JSONDecoder()
                    guard let playlistDecoder = try? decoder.decode(SpotifyPlaylistResponse.self, from: data) else { return }
                    completion(playlistDecoder)
                } else if response.response?.statusCode == 401 {
                    self.requestSpotifyToken() { token in
                    }
                }
            }
        }
    }
    
    func requestSpotifyToken(completion: @escaping(_ token: Token) -> Void) {
        
        let parameters: [String: Any] = [
            "grant_type": "client_credentials",
            "client_id": "888a9ba038a446c39e6cff556f7fc935",
            "client_secret": "ea628a502e214b4a967ed6eb0ff3b84a"
        ]
        
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        AF.request("https://accounts.spotify.com/api/token", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .response { response in
                if let data = response.data {
                    let decoder = JSONDecoder()
                    guard let tokenDecoder = try? decoder.decode(Token.self, from: data) else { return }
                    UserDefaults.standard.set(tokenDecoder.token, forKey: "someObject")
                    print(UserDefaults.standard.string(forKey: "someObject") ?? "")
                    completion(tokenDecoder)
                }
            }
    }
}
