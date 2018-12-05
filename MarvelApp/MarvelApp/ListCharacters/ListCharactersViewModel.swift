//
//  ListCharactersViewModel.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 04/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

enum ChangeState {
    case notLoaded
    case initial
    case inserted([IndexPath])
    case error(Error)
}

protocol ListCharactersViewModelDelegate: AnyObject {
    func didSelected(character: Character)
}

final class ListCharactersViewModel {
    var hasMoreCharacters = true
    var isLoading = false
    var count: Int {
        return characters.count
    }
    
    weak var delegate: ListCharactersViewModelDelegate?
    
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
    
    func fetchCharacters(completion: @escaping (ChangeState) -> Void) {
        guard !isLoading && hasMoreCharacters else {
            completion(.inserted([]))
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
                completion(changeState)
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
    
    func selectCharacter(at indexPath: IndexPath) {
        let character = self[indexPath.row].character
        delegate?.didSelected(character: character)
    }
}
