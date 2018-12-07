//
//  HeaderComicReusableView.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 06/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import UIKit

final class HeaderComicReusableView: UICollectionReusableView {

    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.clipsToBounds = true
        thumbImageView.layer.cornerRadius = 6
    }
    
}
