//
//  QiniuToken.swift
//  seesometop
//
//  Created by laijihua on 04/09/2017.
//
//

import Foundation
import Vapor
import Crypto

class QiniuToken {

    let accessKey: String = "FYdBEAUoeWB4qGnnjrk0z1FG-Wi_EqvIXUAkHkBO"
    let secretKey: String = "EmbLxZU9KsTWILd553l9dqgJ7ryuc7hNUtcCDGtT"
    let scope: String = "twicebook"
    var liveTime: TimeInterval = 5

    static func genereryToken() throws -> String {
        return try QiniuToken().gengeryToken()
    }

    private func gengeryToken() throws -> String  {
        let date = Date().timeIntervalSince1970 + liveTime * 24 * 3600 // Int(date)
        let authInfo: [String : Any] = ["scope": scope,"deadline": Int(date)]
        let jsonData = try JSONSerialization.data(withJSONObject: authInfo, options: .prettyPrinted)
        let encodeString = urlSafeBase64Encode(jsonData)
        let encodedSignedString = try HMACSHA1(secretKey, text: encodeString)

        let token = accessKey + ":" + encodedSignedString + ":" + encodeString
        return token
    }

    private func HMACSHA1(_ key: String, text: String) throws -> String {
        let hmac = try HMAC.make(.sha1, text, key: key)
        let hmacData = Data(bytes: hmac)
        return urlSafeBase64Encode(hmacData)
    }

    private func urlSafeBase64Encode(_ text: Data) -> String {
        var base64 = text.base64EncodedString()
        base64 = base64.replacingOccurrences(of: "+", with: "-")
        base64 = base64.replacingOccurrences(of: "/", with: "_")
        return base64
    }
}
