//
//  JikanReducer.swift
//  MyAnimeList
//
//  Created by HG on 2020/09/22.
//

import Foundation
import SwiftUIFlux

func jikanStateReducer(state: JikanState, action: Action) -> JikanState {
    var state = state
    switch action {
    case let action as JikanActions.SetAnime:
        state.animes[action.malID] = action.response
    case let action as JikanActions.SetTop:
        state.top = action.response
    default:
        break
    }
    return state
}
