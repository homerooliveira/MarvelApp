//
//  String+md5.swift
//  MarvelApp
//
//  Created by Homero Oliveira on 14/12/19.
//  Copyright © 2019 Homero Oliveira. All rights reserved.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

/// https://stackoverflow.com/questions/32163848/how-can-i-convert-a-string-to-an-md5-hash-in-ios-using-swift
extension String {
    func md5() -> String {
            let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = Data(self.utf8)
            var digestData = Data(count: length)

            _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
                messageData.withUnsafeBytes { messageBytes -> UInt8 in
                    if let messageBytesBaseAddress = messageBytes.baseAddress,
                        let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                        let messageLength = CC_LONG(messageData.count)
                        CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                    }
                    return 0
                }
            }
            return digestData.map { String(format: "%02hhx", $0) }.joined()
    }

}
