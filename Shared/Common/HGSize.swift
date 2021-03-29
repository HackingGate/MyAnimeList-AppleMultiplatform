//
//  HGSize.swift
//  MyAnimeList
//
//  Created by HG on 2021/03/29.
//

import Foundation

protocol HGSizeProtocol {
    var width: CGFloat { get set }
    var height: CGFloat { get set }
    var ratio: CGFloat { get set }

    init(width: CGFloat, height: CGFloat)
    init(width: CGFloat, ratio: CGFloat)
    init(height: CGFloat, ratio: CGFloat)
}

struct HGSize: HGSizeProtocol {
    var width: CGFloat

    var height: CGFloat

    var ratio: CGFloat

    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
        self.ratio = height / width
    }

    init(width: CGFloat, ratio: CGFloat) {
        self.width = width
        self.height = width * ratio
        self.ratio = ratio
    }

    init(height: CGFloat, ratio: CGFloat) {
        self.width = height / ratio
        self.height = height
        self.ratio = ratio
    }
}
