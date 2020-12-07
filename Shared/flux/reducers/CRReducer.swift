//
//  CRReducer.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import Foundation
import SwiftUIFlux

func crStateReducer(state: CRState, action: Action) -> CRState {
    var state = state
    switch action {
    case let action as CRActions.SetSession:
        state.session = action.response.data
    case let action as CRActions.SetCollections:
        if let collections = action.response.data {
            state.series[action.seriesId] = collections
        }
    case let action as CRActions.SetMedia:
        if let medias = action.response.data {
            state.collections[action.collectionId] = medias
            medias.forEach { media in
                if let mediaId = Int(media.id) {
                    state.medias[mediaId] = media
                    state.mediaIdToCollectionId[mediaId] = action.collectionId
                }
            }
        }
    case let action as CRActions.SetInfo:
        if let media = action.response.data {
            if let streamData = media.streamData {
                // media already exist
                state.medias[action.mediaId]?.streamData = streamData
            } else {
                fatalError("Cannot update CRMedia")
//                state.medias[action.mediaId] = media
            }
            if let collectionIdString = media.collectionId, let collectionId = Int(collectionIdString) {
                state.mediaIdToCollectionId[action.mediaId] = collectionId
            }
        }
    default:
        break
    }
    return state
}
