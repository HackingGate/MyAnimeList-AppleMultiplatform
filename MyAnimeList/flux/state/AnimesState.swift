//
//  AnimesState.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import Foundation
import SwiftUIFlux

struct AnimesState: FluxState, Codable {
    var session: CRUnblockerStartSession?
    var series: [Int: [CRAPICollection]] = [:]
    var collections: [Int: [CRAPIEpisode]] = [:]
    var episodes: [Int: CRAPIEpisode] = [:]
    var playerItems: [Int: PlayerItem] = [:]
}
