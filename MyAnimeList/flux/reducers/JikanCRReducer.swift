//
//  JikanCRReducer.swift
//  MyAnimeList
//
//  Created by HG on 2020/09/22.
//

import Foundation
import SwiftUIFlux

func jikanCRStateReducer(state: JikanCRState, action: Action) -> JikanCRState {
    var state = state
    switch action {
    case let action as JikanCRActions.SetMalIdSeriesId:
        state.malIdSeriesId[action.malId] = action.seriesId
    default:
        break
    }
    return state
}
