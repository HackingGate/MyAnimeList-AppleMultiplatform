//
//  CommonImageSize.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/13.
//

import CoreGraphics

struct CommonImageSize {
    #if os(tvOS)
    static let posterImage = CGSize(width: 200.0, height: 300.0)
    static let episodeImage = CGSize(width: 320.0, height: 180.0)
    #elseif targetEnvironment(macCatalyst)
    static let posterImage = CGSize(width: 150.0, height: 225.0)
    static let episodeImage = CGSize(width: 240.0, height: 135.0)
    #else
    static let posterImage = CGSize(width: 100.0, height: 150.0)
    static let episodeImage = CGSize(width: 160.0, height: 90.0)
    #endif
}
