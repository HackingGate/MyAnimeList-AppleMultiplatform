//
//  Common.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/13.
//

import Foundation
import SwiftUI

struct Common {
    struct PosterImage {
        #if os(tvOS)
        static let width: CGFloat = 200.0
        #else
        static let width: CGFloat = 100.0
        #endif
        static var heigth: CGFloat {
            width * ratio
        }
        static let ratio: CGFloat = 1.5
    }
}
