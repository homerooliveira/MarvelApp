//
//  ListCharactersViewModel.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 04/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

protocol ListCharactersViewModelDelegate: AnyObject {
    func didSelected(character: Character)
}

final class ListCharactersViewModel {
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
    
    weak var delegate: ListCharactersViewModelDelegate?
    
    let marvelApiProvider: MarvelApiProviderType
    let paginator: Paginator<Character>
    
    subscript(_ index: Int) -> CharacterViewModel {
        return CharacterViewModel(character: paginator.results[index])
    }
    
    init(marvelApiProvider: MarvelApiProviderType,
         paginator: Paginator<Character> = Paginator()) {
        self.marvelApiProvider = marvelApiProvider
        self.paginator = paginator
    }
    
    func fetchCharacters(completion: @escaping (ChangeState) -> Void) {
        guard !isLoading && hasMore else {
            completion(.inserted([]))
            return
        }
        self.paginator.isLoading = true
        
        let endpoint = MarvelApi.characters(offset: offset)
        
        marvelApiProvider.request(for: endpoint) { [weak self] (result: Result<DataWrapper<Character>>) in
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
    
    func selectCharacter(at indexPath: IndexPath) {
        let character = self[indexPath.row].character
        delegate?.didSelected(character: character)
    }
}
