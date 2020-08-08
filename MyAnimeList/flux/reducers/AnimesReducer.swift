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
        print(action)
    case let action as AnimesActions.SetMedia:
        print(action)
    case let action as AnimesActions.SetInfo:
        print(action)
    default:
        break
    }
    return state
}
