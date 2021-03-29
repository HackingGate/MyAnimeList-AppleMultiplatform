//
//  CommonImageSize.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/13.
//

import Foundation

struct CommonImageSize {
    #if os(tvOS)
    static let posterImage = HGSize(width: 200.0, ratio: 1.5)
    static let episodeImage = HGSize(width: 320.0, ratio: 1.5)
    #elseif targetEnvironment(macCatalyst)
    static let posterImage = HGSize(width: 150.0, ratio: 1.5)
    static let episodeImage = HGSize(width: 240.0, ratio: 1.5)
    #else
    static let posterImage = HGSize(width: 100.0, ratio: 1.5)
    static let episodeImage = HGSize(width: 160.0, ratio: 1.5)
    #endif
}
