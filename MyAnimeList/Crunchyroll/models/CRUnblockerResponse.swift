//
//  CRUnblockerResponse.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/06.
//

import Foundation

struct CRUnblockerResponse<T: Codable>: Codable {
    let data: T
    let error: Bool
    let code: String
}
