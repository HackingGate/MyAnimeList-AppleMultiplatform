//
//  CommonImageSize.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/13.
//

import CoreGraphics

struct CommonImageSize {
    static let basePosterSize = CGSize(width: 10, height: 15)
    static let baseEpisodeSize = CGSize(width: 16, height: 9)
    #if os(tvOS)
    static let posterImage = baseSize(size: CommonImageSize.basePosterSize, multipiler: 18)
    static let episodeImage = baseSize(size: CommonImageSize.baseEpisodeSize, multipiler: 18)
    #elseif targetEnvironment(macCatalyst)
    static let posterImage = baseSize(size: CommonImageSize.basePosterSize, multipiler: 15)
    static let episodeImage = baseSize(size: CommonImageSize.baseEpisodeSize, multipiler: 15)
    #else
    static let posterImage = baseSize(size: CommonImageSize.basePosterSize, multipiler: 10)
    static let episodeImage = baseSize(size: CommonImageSize.baseEpisodeSize, multipiler: 10)
    #endif
}

func baseSize(size: CGSize, multipiler: CGFloat) -> CGSize {
    return CGSize(width: size.width * multipiler, height: size.height * multipiler)
}
