//
//  File.swift
//  TellTenMobile
//
//  Created by kbs on 1/28/16.
//  Copyright © 2016 kbs. All rights reserved.
//

import Foundation


 // Swift 2.0, minor warning on Swift 1.2
func md5(string string: String) -> String {
    var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
    if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
        CC_MD5(data.bytes, CC_LONG(data.length), &digest)
    }
    
    var digestHex = ""
    for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
        digestHex += String(format: "%02x", digest[index])
    }
    
    return digestHex
}