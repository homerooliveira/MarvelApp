//
//  UIImageView+loadImage.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 07/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func load(image: Image) {
        let url = URL(string: image.urlString)
        kf.setImage(with: url)
    }
}
