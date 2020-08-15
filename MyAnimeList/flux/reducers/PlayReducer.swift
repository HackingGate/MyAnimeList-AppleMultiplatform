//
//  PlayReducer.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/15.
//

import Foundation
import SwiftUIFlux

func playStateReducer(state: PlayState, action: Action) -> PlayState {
    var state = state
    switch action {
    case let action as PlayActions.SetPlayerItem:
        state.playerItems[action.mediaId] = action.playerItem
    default:
        break
    }
    return state
}
