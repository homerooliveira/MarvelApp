//
//  Image.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 07/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

struct Image: Decodable, Equatable {
    let path: String
    let `extension`: String
}

extension Image {
    var urlString: String {
        return path + "." + `extension`
    }
}
