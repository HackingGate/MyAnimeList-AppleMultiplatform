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
            if action.filter == .airing {
                if action.type == .tv {
                    state.topAnimeTvAiring = action.response
                } else if action.type == .movie {
                    state.topAnimeMovieAiring = action.response
                }
            } else if action.filter == .bypopularity {
                if action.type == .tv {
                    state.topAnimeTvBypopularity = action.response
                } else if action.type == .movie {
                    state.topAnimeMovieBypopularity = action.response
                }
            }
        } else {
            // TODO: append
        }
    default:
        break
    }
    return state
}
