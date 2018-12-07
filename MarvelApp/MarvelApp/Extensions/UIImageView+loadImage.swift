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
        lock()
        kf.setImage(with: url, completionHandler: { [weak self] (_, _, _, _) in
            guard let self = self else { return }
            self.unlock()
        })
    }
}
