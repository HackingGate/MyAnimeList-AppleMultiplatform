//
//  PlayState.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/15.
//

import Foundation
import SwiftUIFlux

struct PlayState: FluxState, Codable {
    var playerItems: [Int: PlayerItem] = [:]
}
