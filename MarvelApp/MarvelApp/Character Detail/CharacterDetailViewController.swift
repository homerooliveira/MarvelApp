//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 06/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import UIKit

final class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel: CharacterDetailViewModel
    
    let headerIdentifier = "header"
    let headerKind = UICollectionView.elementKindSectionHeader
    let footerIdentifier = "footer"
    let footerKind = UICollectionView.elementKindSectionFooter
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = viewModel.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(of: ComicCell.self)
        let nib = UINib(nibName: "HeaderComicReusableView", bundle: nil)
        let header = UICollectionView.elementKindSectionHeader
        collectionView.register(nib,
                                forSupplementaryViewOfKind: header,
                                withReuseIdentifier: "header")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CharacterDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ComicCell = collectionView.dequeueReusableCell(cellForItemAt: indexPath)
        cell.backgroundColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
}

extension CharacterDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: headerKind,
                withReuseIdentifier: headerIdentifier,
                for: indexPath) as? HeaderComicReusableView else {
                return UICollectionReusableView()
            }
            supplementaryView.viewModel = viewModel
            return supplementaryView
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let collectionViewSize = collectionView.frame.size
        let width = collectionViewSize.width * 0.8533333333
        let font = UIFont.systemFont(ofSize: 17)
        let deafultHeight: CGFloat = 200
        
        let calculedHeight = viewModel.description.calculateHeight(width: width, font: font)
        
        return CGSize(width: width, height: deafultHeight + calculedHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  30
        let collectionViewSize = collectionView.frame.size.width - padding
        let percentageOfWidth: CGFloat = 0.50
        let percentageOfHeight: CGFloat = 0.35
        
        return CGSize(width: collectionViewSize * percentageOfWidth,
                      height: collectionView.frame.height * percentageOfHeight)
    }
}
