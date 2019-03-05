//
//  MainCoordinatorTest.swift
//  MarvelAppTests
//
//  Created by Homero Oliveira on 11/01/19.
//  Copyright © 2019 Homero Oliveira. All rights reserved.
//

import XCTest
@testable import MarvelApp

final class MainCoordinatorTest: XCTestCase {
    
    var navigator: MockNavigator!
    var mainCoodinator: MainCoordinator!

    override func setUp() {
        navigator = MockNavigator()
        mainCoodinator = MainCoordinator(navigationController: navigator)
    }

    func testStart() {
        let expectation = XCTestExpectation(description: "startCoordinator")
        
        navigator.pushedViewController = { viewControlller in
            XCTAssert(viewControlller is ListCharactersViewController)
            let delegate = (viewControlller as? ListCharactersViewController)?.viewModel.delegate
            XCTAssert(self.mainCoodinator === delegate)
            expectation.fulfill()
        }
        
        mainCoodinator.start()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testSelectCharacter() {
        let expectation = XCTestExpectation(description: "didSelectedCharacter")
        
        navigator.pushedViewController = { viewControlller in
            XCTAssert(viewControlller is CharacterDetailViewController)
            expectation.fulfill()
        }
        
        let character = Character(
            id: 1,
            name: "Name",
            description: "description",
            thumbnail: Image(path: "test", extension: ".png")
        )
        mainCoodinator.didSelected(character: character)
        
        wait(for: [expectation], timeout: 1)
    }
}
