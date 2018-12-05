//
//  ListCharactersViewModel.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 04/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

enum ChangeState {
    case initial
    case inserted([IndexPath])
}

final class ListCharactersViewModel {
    var hasMoreCharacters = true
    var isLoading = false
    var count: Int {
        return characters.count
    }
    
    private var offset = 0
    private var characters: [Character] = []
    
    let marvelApiProvider: MarvelApiProvider
    let imageLoader: ImageLoader
    
    subscript(_ index: Int) -> CharacterViewModel {
        return CharacterViewModel(character: characters[index], imageLoader: imageLoader)
    }
    
    init(marvelApiProvider: MarvelApiProvider, imageLoader: ImageLoader) {
        self.marvelApiProvider = marvelApiProvider
        self.imageLoader = imageLoader
    }
    
    func fetchCharacters(completion: @escaping (Result<ChangeState>) -> Void) {
        guard !isLoading && hasMoreCharacters else {
            completion(.success(.inserted([])))
            return
        }
        isLoading = true
        
        let endpoint = MarvelApi.characters(offset: offset)
        
        marvelApiProvider.request(for: endpoint) { [weak self] (result: Result<CharacterDataWrapper>) in
            guard let self = self else { return }
            switch result {
            case .success(let dataWrapper):
                self.characters += dataWrapper.data.results
                let indexPaths = (self.offset..<self.characters.count).map { IndexPath(row: $0, section: 0) }
                let changeState: ChangeState = self.offset == 0 ? .initial : .inserted(indexPaths)
                self.offset = dataWrapper.data.count
                self.hasMoreCharacters = self.characters.count <= dataWrapper.data.total
                self.isLoading = false
                completion(.success(changeState))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
