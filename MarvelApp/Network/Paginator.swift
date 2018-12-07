//
//  Paginator.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 07/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

final class Paginator<T> where T: Decodable {
    var hasMore = true
    var isLoading = false
    var offset = 0
    var results: [T] = []
    
    func paginate(dataWrapper: DataWrapper<T>) -> ChangeState {
        self.results += dataWrapper.data.results
        let indexPaths = (self.offset..<self.results.count).map { IndexPath(row: $0, section: 0) }
        let changeState: ChangeState = self.offset == 0 ? .initial : .inserted(indexPaths)
        self.offset += dataWrapper.data.count
        self.hasMore = self.results.count < dataWrapper.data.total
        self.isLoading = false
        return changeState
    }
}

struct LoadingError: Error, Equatable {
    let message: String
}

enum ChangeState: Equatable {
    case notLoaded
    case loading
    case initial
    case inserted([IndexPath])
    case error(LoadingError)
}
