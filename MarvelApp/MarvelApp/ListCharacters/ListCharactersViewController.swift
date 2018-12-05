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
    
    var state: ChangeState = .notLoaded {
        didSet {
            updateUI(state)
        }
    }
    
    init(viewModel: ListCharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Characters"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        viewModel.fetchCharacters { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.state = result
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(of: CharacterCell.self)
    }

    private func updateUI(_ state: ChangeState) {
        switch state {
        case .initial:
            collectionView.reloadData()
        case .inserted(let indexPaths):
            collectionView.insertItems(at: indexPaths)
        case .error(let error):
            print(error)
        default:
            break
        }
    }
}

extension ListCharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharacterCell = collectionView.dequeueReusableCell(cellForItemAt: indexPath)
        cell.viewModel = viewModel[indexPath.row]
        return cell
    }
}

extension ListCharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = viewModel[indexPath.row].character
        delegate?.didSelected(character: character)
    }
}

extension ListCharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
}
