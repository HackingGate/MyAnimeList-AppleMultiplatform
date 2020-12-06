//
//  MALSyncReducer.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/06.
//

import Foundation
import SwiftUIFlux

func malSyncStateReducer(state: MALSyncState, action: Action) -> MALSyncState {
    var state = state
    switch action {
    case let action as MALSyncActions.SetAnime:
        state.malIDSites[action.malID] = action.response
    default:
        break
    }
    return state
}
