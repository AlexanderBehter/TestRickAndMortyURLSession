//
//  NetworkManager.swift
//  TestRickAndMortyURLSession
//
//  Created by Александр Бехтер on 24.07.2020.
//  Copyright © 2020 Александр Бехтер. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from urlString: String, with complition: @escaping (Character) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            do {
                let character = try JSONDecoder().decode(Character.self, from: data)
                complition(character)
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
            
        }.resume()
    }
}
