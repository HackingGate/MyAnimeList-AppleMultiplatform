//
//  CRAPIEpisode.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/02.
//

import Foundation

// For media.0.json (a list of episodes) and info.0.json (episode)
struct CRAPIEpisode: Codable, Identifiable {
    let id: String // media_id
    let collectionId: String
    let episodeNumber: String
    let name: String
    let description: String
    let url: String
    let seriesName: String
    let collectionName: String
    let premiumOnly: Bool
    let playhead: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "media_id"
        case collectionId = "collection_id"
        case episodeNumber = "episode_number"
        case name = "name"
        case description = "description"
        case url = "url"
        case seriesName = "series_name"
        case collectionName = "collection_name"
        case premiumOnly = "premium_only"
        case playhead = "playhead"
    }
}
