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
        if action.page == 1 {
            switch action.subtype {
            case .airing:
                state.topAiring = action.response
            case .upcoming:
                state.topUpcoming = action.response
            case .tv:
                state.topTv = action.response
            case .movie:
                state.topMovie = action.response
            case .ova:
                state.topOva = action.response
            case .special:
                state.topSpecial = action.response
            case .bypopularity:
                state.topBypopularity = action.response
            case .favorite:
                state.topFavorite = action.response
            default:
                fatalError("Unsupported subtype")
            }
            if action.subtype == .airing {
                state.topAiring = action.response
            }
        } else {
            // TODO: append
        }
    default:
        break
    }
    return state
}
