//
//  JikanState.swift
//  MyAnimeList
//
//  Created by HG on 2020/09/22.
//

import Foundation
import SwiftUIFlux
import JikanSwift

struct JikanState: FluxState, Codable {
    var top: JikanAPITop<[JikanAPIAnime]>?
    var animes: [Int: JikanAPIAnime] = [:]
}
