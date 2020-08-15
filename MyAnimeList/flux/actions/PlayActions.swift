//
//  PlayActions.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/15.
//

import Foundation
import SwiftUIFlux

struct PlayActions {
    struct SavePlayerItem: AsyncAction {
        let mediaId: Int
        let playerItem: PlayerItem
        
        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            dispatch(SetPlayerItem(mediaId: mediaId,
                                    playerItem: playerItem))
        }
    }
    
    struct SetPlayerItem: Action {
        let mediaId: Int
        let playerItem: PlayerItem
    }
}
