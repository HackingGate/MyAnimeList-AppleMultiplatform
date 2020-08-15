//
//  CRState.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import Foundation
import SwiftUIFlux

struct CRState: FluxState, Codable {
    var session: CRUnblockerStartSession?
    var series: [Int: [CRAPICollection]] = [:]
    var collections: [Int: [CRAPIMedia]] = [:]
    var medias: [Int: CRAPIMedia] = [:]
}
