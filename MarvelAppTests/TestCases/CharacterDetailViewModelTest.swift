//
//  CharacterDetailTest.swift
//  MarvelAppTests
//
//  Created by Homero Oliveira on 07/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import XCTest
@testable import MarvelApp

final class CharacterDetailTest: XCTestCase {

    var viewModel: CharacterDetailViewModel!
    var character: MarvelApp.Character!
    
    override func setUp() {
        let urlSession = mockSession()
        let marvelApiProvider = MarvelApiProvider(session: urlSession)
        
        let image = Image(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", extension: "jpg")
        character = Character(id: 1011334, name: "3-D Man", description: "descrition", thumbnail: image)
        
        viewModel = CharacterDetailViewModel(character: character, marvelApiProvider: marvelApiProvider)
    }
    
    func testInitialFetch() throws {
        let mockJSONData = try loadFile(forResource: "comics", withExtension: "json")
        MockURLProtocol.requestHandler = { (request) in
            XCTAssertEqual(request.url?.query?.contains("offset=0"), true)
            XCTAssertEqual(request.url?.path, "/v1/public/characters/\(self.character.id)/comics")
            return (HTTPURLResponse(), mockJSONData)
        }
        
        let expectation = XCTestExpectation(description: "fetchComics")
        
        viewModel.fetchComics { [weak self] (state) in
            guard let self = self else {
                XCTFail("shold have self reference")
                return
            }
            let expectedValue = ChangeState.initial
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertEqual(state, expectedValue)
            XCTAssertEqual(self.viewModel.count, 1)
            XCTAssertEqual(self.viewModel.name, self.character.name)
            XCTAssertEqual(self.viewModel.description, self.character.description)
            XCTAssertEqual(self.viewModel.thumbnail, self.character.thumbnail)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testAcessingComicViewModel() {
        let urlSession = mockSession()
        let marvelApiProvider = MarvelApiProvider(session: urlSession)
        
        character = MarvelApp.Character(id: character.id,
                                        name: character.name,
                                        description: "",
                                        thumbnail: character.thumbnail)
        
        let image = Image(path: "http://i.annihil.us/u/prod/marvel/i/mg/d/03/58dd080719806",
                          extension: "png")
        
        let comic = Comic(id: 22506, thumbnail: image)
        let paginator: Paginator<Comic> = Paginator()
        paginator.results = [comic]
        
        viewModel = CharacterDetailViewModel(character: character,
                                             marvelApiProvider: marvelApiProvider,
                                             paginator: paginator)
        XCTAssertEqual(self.viewModel[0].comic, comic)
        XCTAssertEqual(self.viewModel.description, "Description not available.")
    }
    
//    func testAcessingCharacterViewModel() throws {
//        let urlSession = mockSession()
//        let marvelApiProvider = MarvelApiProvider(session: urlSession)
//
//
//        let paginator: Paginator<MarvelApp.Character> = Paginator()
//        paginator.results = [character]
//
//        viewModel = ListCharactersViewModel(marvelApiProvider: marvelApiProvider,
//                                            paginator: paginator)
//
//        XCTAssertEqual(self.viewModel[0].character, character)
//    }
}
