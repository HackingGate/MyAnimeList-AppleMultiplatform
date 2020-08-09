//
//  CRAPIStream.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/09.
//

import Foundation

struct CRAPIStream: Codable {
    let quality: String
    let expires: String
    let url: String
}
