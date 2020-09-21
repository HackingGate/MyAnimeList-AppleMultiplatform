//
//  JikanActions.swift
//  MyAnimeList
//
//  Created by HG on 2020/09/21.
//

import Foundation
import SwiftUIFlux
import JikanSwift

struct JikanActions {
    
    // MARK: - Requests
    
    struct Anime: AsyncAction {
        // https://jikan.docs.apiary.io/#reference/0/anime
        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            JikanAPIService.shared.loadAnime(
                id: 1,
                request: "/",
                params: nil)
            {
                (result: Result<JikanAPIAnime, JikanAPIService.APIError>) in
                switch result {
                case let .success(response):
                    #if DEBUG
                    print(response)
                    #endif
                case .failure(_):
                    break
                }
            }
        }
    }
}
