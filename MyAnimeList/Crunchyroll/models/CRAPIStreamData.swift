//
//  CRAPIStreamData.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/09.
//

import Foundation

struct CRAPIStreamData: Codable {
    let hardsubLang: String?
    let audioLang: String?
    let format: String?
    let streams: [CRAPIStream]
    
    enum CodingKeys: String, CodingKey {
        case hardsubLang = "hardsub_lang"
        case audioLang = "audio_lang"
        case format = "format"
        case streams = "streams"
    }
}
