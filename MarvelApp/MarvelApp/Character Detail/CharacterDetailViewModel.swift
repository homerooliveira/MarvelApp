//
//  CharacterViewModel.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 06/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

final class CharacterDetailViewModel {
    private let character: Character
    
    var name: String {
        return character.name
    }
    
    var description: String {
        if character.description.isEmpty {
            return "Description not available."
        } else {
            return character.description
        }
    }
    
    let marvelApiProvider: MarvelApiProviderType
    
    init(character: Character, marvelApiProvider: MarvelApiProviderType) {
        self.character = character
        self.marvelApiProvider = marvelApiProvider
    }
}
