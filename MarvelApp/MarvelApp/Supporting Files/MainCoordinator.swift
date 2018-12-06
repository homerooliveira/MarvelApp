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
    var navigationController: UINavigationController { get set }
    
    func start()
}

final class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let marvelApiProvider: MarvelApiProviderType = MarvelApiProvider()
    let imageLoader: ImageLoader = ImageLoader()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupNavigationController(navigationController)
    }
    
    private func setupNavigationController(_ navigationController: UINavigationController) {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.barStyle = .blackTranslucent
    }
    
    func start() {
        let vm = ListCharactersViewModel(marvelApiProvider: marvelApiProvider, imageLoader: imageLoader)
        vm.delegate = self
        let vc = ListCharactersViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: false)
    }
}

extension MainCoordinator: ListCharactersViewModelDelegate {
    func didSelected(character: Character) {

        let vm = CharacterDetailViewModel(character: character,
                                          marvelApiProvider: marvelApiProvider)
        let vc = CharacterDetailViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}
