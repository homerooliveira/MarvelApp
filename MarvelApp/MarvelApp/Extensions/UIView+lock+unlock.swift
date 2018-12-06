//
//  UIView+lock+unlock.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 06/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import UIKit

private let activityTag = 1234

extension UIView {
    func lock(style:  UIActivityIndicatorView.Style = .whiteLarge) {
        guard viewWithTag(activityTag) == nil else { return }
        
        let activity = UIActivityIndicatorView(style: style)
        
        activity.tag = activityTag
        activity.hidesWhenStopped = true
        activity.startAnimating()
        
        addSubview(activity)
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
    func unlock() {
        guard let view = viewWithTag(activityTag) as? UIActivityIndicatorView else { return }
        view.stopAnimating()
        view.removeFromSuperview()
    }
}
