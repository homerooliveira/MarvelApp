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
    
    var state: ChangeState = .notLoaded {
        didSet {
            updateUI(state)
        }
    }
    
    let headerIdentifier = "header"
    let headerKind = UICollectionView.elementKindSectionHeader
    let footerIdentifier = "footer"
    let footerKind = UICollectionView.elementKindSectionFooter
    let headerNibName = "HeaderComicReusableView"
    
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
        
        state = .loading
        viewModel.fetchComics { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.state = result
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(of: ComicCell.self)
        let nib = UINib(nibName: headerNibName, bundle: nil)
        collectionView.register(nib,
                                forSupplementaryViewOfKind: headerKind,
                                withReuseIdentifier: headerIdentifier)
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: footerKind,
                                withReuseIdentifier: footerIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func updateUI(_ state: ChangeState) {
        switch state {
        case .initial:
            view.unlock()
            collectionView.reloadData()
        case .inserted(let indexPaths):
            collectionView.insertItems(at: indexPaths)
        case .error(let error):
            print(error)
        case .loading:
            view.lock()
        default:
            break
        }
    }
}

extension CharacterDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ComicCell = collectionView.dequeueReusableCell(cellForItemAt: indexPath)
        cell.viewModel = viewModel[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case headerKind:
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: headerKind,
                withReuseIdentifier: headerIdentifier,
                for: indexPath) as? HeaderComicReusableView else {
                    return UICollectionReusableView()
            }
            supplementaryView.viewModel = viewModel
            return supplementaryView
        case footerKind:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: footerKind,
                                                                                    withReuseIdentifier: footerIdentifier,
                                                                                    for: indexPath)
            return supplementaryView
        default:
            return UICollectionReusableView()
        }
    }
    
}

extension CharacterDetailViewController: UICollectionViewDelegateFlowLayout {
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

extension CharacterDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.hasReachBottom && !viewModel.isLoading && viewModel.hasMore else { return }
        let indexPath = IndexPath(item: 0, section: 0)
        let footer = collectionView.supplementaryView(forElementKind: footerKind, at: indexPath)
        footer?.lock()
        viewModel.fetchComics { [weak self, footer] (change) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                footer?.unlock()
                self.state = change
            }
        }
    }
}
