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
    private let paginator: Paginator<Comic>
    
    var count: Int {
        return paginator.results.count
    }
    var offset: Int {
        return paginator.offset
    }
    var hasMore: Bool {
        return paginator.hasMore
    }
    var isLoading: Bool {
        return paginator.isLoading
    }
    
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
    
    var thumbnail: Image {
        return character.thumbnail
    }
    
    let marvelApiProvider: MarvelApiProviderType
    
    subscript(_ index: Int) -> ComicViewModel {
        return ComicViewModel(comic: paginator.results[index])
    }
    
    init(character: Character,
         marvelApiProvider: MarvelApiProviderType,
         paginator: Paginator<Comic> = Paginator()) {
        self.character = character
        self.marvelApiProvider = marvelApiProvider
        self.paginator = paginator
    }
    
    func fetchComics(completion: @escaping (ChangeState) -> Void) {
        guard !isLoading && hasMore else {
            completion(.inserted([]))
            return
        }
        self.paginator.isLoading = true
        
        let endpoint = MarvelApi.comics(characterId: character.id, offset: offset)
        
        marvelApiProvider.request(for: endpoint) { [weak self] (result: Result<DataWrapper<Comic>>) in
            guard let self = self else { return }
            switch result {
            case .success(let dataWrapper):
                let changeState = self.paginator.paginate(dataWrapper: dataWrapper)
                completion(changeState)
            case .failure(let error):
                completion(.error(LoadingError(message: error.localizedDescription)))
            }
        }
    }
}
