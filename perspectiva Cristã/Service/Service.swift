//
//  Service.swift
//  perspectiva Cristã
//
//  Created by Jonatas Gama on 28/02/23.
//

import Foundation

class Service {
    
    func requestApi(completion: @escaping(_ station: Station) -> Void) {
        
        // Cria uma URL para a API que queremos acessar
        guard let url = URL(string: "https://s09.w3bserver.com/api/nowplaying_static/perspectiva_crista.json") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Cria uma tarefa de data task
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            
            guard let data = data else { return }
            
            guard let stationDecoder = try? decoder.decode(Station.self, from: data) else { return }
            
            completion(stationDecoder)
            
            print(stationDecoder)
            
        }
        
        task.resume()
    }
    
}


// Verifica se ocorreu algum erro
//            if let error = error {
//                print("Erro: \(error)")
//                return
//            }
//
//            // Verifica se há dados retornados
//            guard let data = data else {
//                print("Nenhum dado retornado")
//                return
//            }
//
//            // Cria uma instância JSONDecoder
//            let decoder = JSONDecoder()
//
//            guard let stacionJsonData = stacionJson.data(using: .utf8) else { return }
//
//            let thisStation = try? decoder.decode(Station.self, from: data)
//            print(thisStation)
//            // Decodifica os dados JSON em um objeto Stacion
//            do {
//                let stacionDecode = try decoder.decode(Station.self, from: data)
//                print(stacionDecode)
//                print(Station.CodingKeys.name) // Imprime o nome da pessoa
//            } catch let error {
//                print("Erro ao decodificar JSON: \(error.localizedDescription)")
//            }
