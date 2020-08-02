//
//  CRCollection.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/02.
//

import Foundation

struct CRCollection: Codable, Identifiable {
    let id: String // collection_id
    let seriesId: String
    let name: String
    let description: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id = "collection_id"
        case seriesId = "series_id"
        case name = "name"
        case description = "description"
        case created = "created"
    }
}
