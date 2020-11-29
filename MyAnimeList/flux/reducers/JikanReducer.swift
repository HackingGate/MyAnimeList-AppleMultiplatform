//
//  JikanReducer.swift
//  MyAnimeList
//
//  Created by HG on 2020/09/22.
//

import Foundation
import SwiftUIFlux
import CrunchyrollSwiftWeb

func jikanStateReducer(state: JikanState, action: Action) -> JikanState {
    var state = state
    switch action {
    case let action as JikanActions.SetAnime:
        state.animes[action.malID] = action.response
        
        // TODO: improve
        if let titleEnglish = action.response.titleEnglish {
            let nameToken = CRNameParser.nameToken(titleEnglish)
            if let session = store.state.crState.session,
               let seriesID = CRWebParser.seriesId(nameToken) {
                store.dispatch(action: JikanCRActions.SetMalIdSeriesId(malId: action.response.id, seriesId: seriesID))
                store.dispatch(action: CRActions.ListCollections(sessionId: session.id,
                                                                 seriesId: seriesID))
            }
        }
    case let action as JikanActions.SetTop:
        if action.page == 1 {
            state.top = action.response
        } else {
            // TODO: append
        }
    default:
        break
    }
    return state
}
