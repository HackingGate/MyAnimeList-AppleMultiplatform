//
//  AppState.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import Foundation
import SwiftUIFlux

struct AppState: FluxState, Codable {
    var animesState: AnimesState
    
    init() {
        self.animesState = AnimesState()
    }
}
