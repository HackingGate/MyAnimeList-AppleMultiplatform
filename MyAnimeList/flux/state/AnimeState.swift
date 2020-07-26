//
//  AnimeState.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import Foundation
import SwiftUIFlux

struct AnimesState: FluxState, Codable {
    var animes: [Int: Anime] = [:]
}
