//
//  UIScrollView+reachBottom.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 07/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import UIKit

extension UIScrollView {
    var hasReachBottom: Bool {
        let height = frame.height
        let visibleHeight = height - contentInset.top - contentInset.bottom
        let yPoint = contentOffset.y + contentInset.top
        let threshold = max(0.0, contentSize.height - visibleHeight)
        return yPoint > threshold
    }
}
