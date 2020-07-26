//
//  AppReducer.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import Foundation
import SwiftUIFlux

func appStateReducer(state: AppState, action: Action) -> AppState {
    var state = state
    state.animesState = animesStateReducer(state: state.animesState, action: action)
    return state
}
