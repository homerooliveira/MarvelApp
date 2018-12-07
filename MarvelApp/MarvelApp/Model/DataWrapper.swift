//
//  CharacterDataWrapper.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 04/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

struct DataWrapper<T> {
    let data: DataContainer<T>
}

extension DataWrapper: Decodable where T: Decodable {}
extension DataWrapper: Equatable where T: Equatable {}

struct DataContainer<T> {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}

extension DataContainer: Decodable where T: Decodable {}
extension DataContainer: Equatable where T: Equatable {}
