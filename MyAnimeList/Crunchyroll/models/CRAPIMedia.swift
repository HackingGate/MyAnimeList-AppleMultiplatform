//
//  CRAPIMedia.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/02.
//

import Foundation

struct CRAPIMedia: Codable, Identifiable {
    let id: String // media_id
    let collectionId: String
    let episodeNumber: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "media_id"
        case collectionId = "collection_id"
        case episodeNumber = "episode_number"
        case name = "name"
    }
}
