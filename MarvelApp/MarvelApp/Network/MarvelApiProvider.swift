//
//  MarvelApiProvider.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 04/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

final class MarvelApiProvider {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(for endpoint: MarvelApi,
                               completion: @escaping (Result<T>) -> Void) {
        guard let url = try? endpoint.makeUrl() else { return }
        
        session.dataTask(with: url) { (data, urlResponse, error) in
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let model = try jsonDecoder.decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
