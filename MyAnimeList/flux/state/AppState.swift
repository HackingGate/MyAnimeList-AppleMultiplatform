//
//  AppState.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import Foundation
import SwiftUIFlux

struct AppState: FluxState, Codable {
    var jikanState: JikanState
    var jikanCRState: JikanCRState
    var crState: CRState
    var playState: PlayState
    
    init() {
        self.jikanState = JikanState()
        self.jikanCRState = JikanCRState()
        self.crState = CRState()
        self.playState = PlayState()
    }
}
