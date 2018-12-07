//
//  ListCharactersViewModelTest.swift
//  MarvelAppTests
//
//  Created by Homero Oliveira on 05/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import XCTest
@testable import MarvelApp

final class ListCharactersViewModelTest: XCTestCase {

    var viewModel: ListCharactersViewModel!
    
    override func setUp() {
        let urlSession = mockSession()
        let marvelApiProvider = MarvelApiProvider(session: urlSession)
        
        viewModel = ListCharactersViewModel(marvelApiProvider: marvelApiProvider)
    }

    func testInitialFetch() throws {
        let mockJSONData = try loadFile(forResource: "characters", withExtension: "json")
        MockURLProtocol.requestHandler = { (request) in
            XCTAssertEqual(request.url?.query?.contains("offset=0"), true)
            return (HTTPURLResponse(), mockJSONData)
        }
        
        let expectation = XCTestExpectation(description: "fetchCharacters")
        
        viewModel.fetchCharacters { (state) in
            let expectedValue = ChangeState.initial
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(state, expectedValue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testAcessingCharacterViewModel() throws {
        let urlSession = mockSession()
        let marvelApiProvider = MarvelApiProvider(session: urlSession)
        
        let image = Image(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", extension: "jpg")
        let character = Character(id: 1011334, name: "3-D Man", description: "", thumbnail: image)
        
        let paginator: Paginator<MarvelApp.Character> = Paginator()
        paginator.results = [character]
        
        viewModel = ListCharactersViewModel(marvelApiProvider: marvelApiProvider,
                                            paginator: paginator)
        
        XCTAssertEqual(self.viewModel[0].character, character)
    }
    
    func testDidSelectedCharacter() {
        let urlSession = mockSession()
        let marvelApiProvider = MarvelApiProvider(session: urlSession)
        
        let image = Image(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", extension: "jpg")
        let expectedCharacter = Character(id: 1011334, name: "3-D Man", description: "", thumbnail: image)
        
        let paginator: Paginator<MarvelApp.Character> = Paginator()
        paginator.results = [expectedCharacter]
        
        viewModel = ListCharactersViewModel(marvelApiProvider: marvelApiProvider,
                                            paginator: paginator)
        
        let expectation = XCTestExpectation(description: "didSelectedCharacter")
        
        let mockDelegate = MockListCharacterViewModelDelegate()
        viewModel.delegate = mockDelegate
        
        mockDelegate.didSelectedCharacter = { character in
            XCTAssertEqual(character, expectedCharacter)
            expectation.fulfill()
        }
        
        let indexPath = IndexPath(item: 0, section: 0)
        viewModel.selectCharacter(at: indexPath)
        
        wait(for: [expectation], timeout: 1)
    }
}
