//
//  HeaderComicReusableView.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 06/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import UIKit
import Kingfisher

final class HeaderComicReusableView: UICollectionReusableView {

    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var viewModel: CharacterDetailViewModel! {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.clipsToBounds = true
        thumbImageView.layer.cornerRadius = 6
    }
    
    private func updateUI() {
        nameLabel.text = viewModel.description
        let url = URL(string: viewModel.thumbnail.urlString)
        thumbImageView.kf.setImage(with: url)
    }
    
}
