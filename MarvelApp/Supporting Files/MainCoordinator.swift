//
//  MainCoordinator.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 05/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: Navigator { get set }
    
    func start()
}

protocol Navigator {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
}

extension UINavigationController: Navigator {}

final class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: Navigator
    let marvelApiProvider: MarvelApiProviderType = MarvelApiProvider()
    
    init(navigationController: Navigator) {
        self.navigationController = navigationController
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        guard let navigationController = navigationController as? UINavigationController else { return }
            
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.barStyle = .blackTranslucent
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        let viewModel = ListCharactersViewModel(marvelApiProvider: marvelApiProvider)
        viewModel.delegate = self
        let viewController = ListCharactersViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension MainCoordinator: ListCharactersViewModelDelegate {
    func didSelected(character: Character) {

        let viewModel = CharacterDetailViewModel(character: character,
                                          marvelApiProvider: marvelApiProvider)
        let viewController = CharacterDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
