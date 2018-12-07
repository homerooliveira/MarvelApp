
//
//  MockListCharacterViewModelDelegate.swift
//  MarvelAppTests
//
//  Created by Homero Oliveira on 07/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation
@testable import MarvelApp

final class MockListCharacterViewModelDelegate: ListCharactersViewModelDelegate {
    var didSelectedCharacter: ((MarvelApp.Character) -> Void)?
    
    func didSelected(character: MarvelApp.Character) {
        didSelectedCharacter?(character)
    }
}
