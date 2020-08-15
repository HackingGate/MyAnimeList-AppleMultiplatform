//
//  CRAPIInfo.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/15.
//

import Foundation

struct CRAPIInfo: Codable, Identifiable {
    let id: String // media_id
    let streamData: CRAPIStreamData?
    
    enum CodingKeys: String, CodingKey {
        case id = "media_id"
        case streamData = "stream_data"
    }
}
