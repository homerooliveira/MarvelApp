//
//  MarvelApiProvider.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 04/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case invalidData
}

final class MarvelApiProvider: MarvelApiProviderType {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(for endpoint: MarvelApi,
                               completion: @escaping (Result<T>) -> Void) {
        do {
            let url = try endpoint.makeUrl()
            request(for: url, completion: completion)
        } catch {
            completion(.failure(error))
        }
        
    }
    
    private func request<T: Decodable>(for url: URL, completion: @escaping (Result<T>) -> Void) {
        session.dataTask(with: url) { (data, urlResponse, error) in
            guard let data = data else {
                let newError = error == nil ? ApiError.invalidData : error!
                completion(.failure(newError))
                return
            }
            
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
