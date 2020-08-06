//
//  CRUnblockerStartSession.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/06.
//

import Foundation

struct CRUnblockerStartSession: Codable, Identifiable {
    let id: String // session_id
    let countryCode: String?
    let ip: String?
    let deviceType: String?
    let deviceId: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "session_id"
        case countryCode = "country_code"
        case ip = "ip"
        case deviceType = "device_type"
        case deviceId = "device_id"
//        case user = "user"
//        case auth = "auth"
//        case expires = "expires"
//        case version = "version"
    }
}
