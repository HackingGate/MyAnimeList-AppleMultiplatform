//
//  Common.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/13.
//

import Foundation
import SwiftUI

protocol ImageType {
    var width: CGFloat { get set }
    var height: CGFloat { get set }
    var ratio: CGFloat { get set }
    
    init(width: CGFloat, height: CGFloat)
    init(width: CGFloat, ratio: CGFloat)
    init(height: CGFloat, ratio: CGFloat)
}

struct Common {
    struct Image: ImageType {
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
    
    #if os(tvOS)
    let posterImage = Image(width: 200.0, height: 300.0)
    let episodeImage = Image(width: 320.0, height: 180.0)
    #else
    let posterImage = Image(width: 100.0, height: 150.0)
    let episodeImage = Image(width: 160.0, height: 90.0)
    #endif
}
