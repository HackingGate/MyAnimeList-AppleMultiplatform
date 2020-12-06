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
    state.jikanState = jikanStateReducer(state: state.jikanState, action: action)
    state.jikanCRState = jikanCRStateReducer(state: state.jikanCRState, action: action)
    state.malSyncState = malSyncStateReducer(state: state.malSyncState, action: action)
    state.crState = crStateReducer(state: state.crState, action: action)
    state.playState = playStateReducer(state: state.playState, action: action)
    return state
}
