//
//  Comic.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 07/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

struct Comic: Decodable, Equatable {
    let id: Int
    let thumbnail: Image
}
