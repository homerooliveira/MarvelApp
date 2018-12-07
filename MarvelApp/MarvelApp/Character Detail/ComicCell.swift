//
//  ComicCell.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 06/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import UIKit
import Kingfisher

final class ComicCell: UICollectionViewCell {
    @IBOutlet weak var comicImageView: UIImageView!
    
    var viewModel: ComicViewModel! {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        comicImageView.layer.cornerRadius = 6
        comicImageView.clipsToBounds = true
    }

    
    private func updateUI() {
        let url = URL(string: viewModel.comic.thumbnail.urlString)
        comicImageView.kf.setImage(with: url)
    }
}
