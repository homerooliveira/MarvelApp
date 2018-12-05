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
    let marvelApiProvider: MarvelApiProvider = MarvelApiProvider()
    let imageLoader: ImageLoader = ImageLoader()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
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
        print(character)
    }
}
