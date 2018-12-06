//
//  CharacterViewModel.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 05/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

final class CharacterViewModel {
    
    let character: Character
    let imageLoader: ImageLoader
    
    init(character: Character, imageLoader: ImageLoader) {
        self.character = character
        self.imageLoader = imageLoader
    }
}
