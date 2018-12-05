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
    
    private func updateUI() {
        nameLabel.text = viewModel.character.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
