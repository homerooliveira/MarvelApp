//
//  String+calculateHeight.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 07/12/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import UIKit

extension String {
    func calculateHeight(width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.infinity)
        return NSString(string: self)
                    .boundingRect(with: size,
                                  options: [.usesFontLeading, .usesLineFragmentOrigin],
                                  attributes: [.font: font],
                                  context: nil)
                    .height
    }
}
