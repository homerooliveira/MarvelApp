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
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "header",
                for: indexPath) as? HeaderComicReusableView else {
                return UICollectionReusableView()
            }
            supplementaryView.backgroundColor = .red
            supplementaryView.nameLabel.text = viewModel.description
            return supplementaryView
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let collectionViewSize = collectionView.frame.size
        
        let height = NSString(string: viewModel.description).boundingRect(
            with: CGSize(width: 300, height: Double.infinity),
            options: [.usesFontLeading, .usesLineFragmentOrigin],
            attributes: [.font : UIFont.systemFont(ofSize: 17)],
            context: nil).height
        
        return CGSize(width: collectionViewSize.width, height: 142 + height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding - 10
        
        return CGSize(width: collectionViewSize/2, height: collectionView.frame.height * 0.20)
    }
}
