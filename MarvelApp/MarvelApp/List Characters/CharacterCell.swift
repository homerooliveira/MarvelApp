//
//  CharacterCell.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 05/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import UIKit

final class CharacterCell: UICollectionViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var viewModel: CharacterViewModel! {
        didSet {
            updateUI()
        }
    }
    @IBOutlet weak var backgroundLabel: UIView!
    
    private func updateUI() {
        nameLabel.text = viewModel.character.name
        let url = URL(string: viewModel.character.thumbnail.urlString)
        thumbImageView.kf.setImage(with: url)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.layer.cornerRadius = 6
        thumbImageView.clipsToBounds = true
        backgroundLabel.layer.cornerRadius = 6
    }

}
