//
//  MarvelApiProviderType.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 05/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

protocol MarvelApiProviderType {
    func request<T: Decodable>(for endpoint: MarvelApi,
                               completion: @escaping (Result<T>) -> Void)
}
