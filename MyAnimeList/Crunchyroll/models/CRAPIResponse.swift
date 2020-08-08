//
//  CRAPIResponse.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/02.
//

import Foundation

struct CRAPIResponse<T: Codable>: Codable {
    let data: T?
    let error: Bool
    let code: String
    let message: String?
}
