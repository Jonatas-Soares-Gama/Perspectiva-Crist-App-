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
        
        guard let url = URL(string: baseUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            guard let stationDecoder = try? decoder.decode(List.self, from: data) else { return }
            completion(stationDecoder)
        }
        .resume()
    }
}
