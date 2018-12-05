//
//  ListCharactersViewController.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 04/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import UIKit

protocol ListCharactersViewControllerDelegate: AnyObject {
    func didSelected(character: Character)
}

final class ListCharactersViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: ListCharactersViewControllerDelegate?
    let viewModel: ListCharactersViewModel
    
    init(viewModel: ListCharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

extension ListCharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharacterCell = collectionView.dequeueReusableCell(cellForItemAt: indexPath)
        return cell
    }
}

extension ListCharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = viewModel[indexPath.row].character
        delegate?.didSelected(character: character)
    }
}
