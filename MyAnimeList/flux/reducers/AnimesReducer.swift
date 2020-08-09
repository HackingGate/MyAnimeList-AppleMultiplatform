//
//  AnimesReducer.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import Foundation
import SwiftUIFlux

func animesStateReducer(state: AnimesState, action: Action) -> AnimesState {
    var state = state
    switch action {
    case let action as AnimesActions.SetSession:
        state.session = action.response.data
    case let action as AnimesActions.SetCollections:
        if let collections = action.response.data {
            state.series[action.seriesId] = collections
        }
    case let action as AnimesActions.SetMedia:
        if let episodes = action.response.data {
            state.collections[action.collectionId] = episodes
        }
    case let action as AnimesActions.SetInfo:
        if let episode = action.response.data {
            state.episodes[action.mediaId] = episode
        }
    default:
        break
    }
    return state
}
