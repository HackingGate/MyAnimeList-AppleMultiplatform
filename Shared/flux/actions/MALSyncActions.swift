//
//  MALSyncActions.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/05.
//

import Foundation
import SwiftUIFlux
import MALSyncSwift

struct MALSyncActions {
    // MARK: - Requests

    struct MALAnime: AsyncAction {
        let id: Int
        let params: [String: String]?

        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            MALSyncAPIService.shared.loadMALAnime(
                id: id,
                params: params)
            { (result: Result<MALSyncAPIMAL, MALSyncAPIService.APIError>) in
                switch result {
                case let .success(response):
                    #if DEBUG
                    print(response)
                    #endif
                    dispatch(SetAnime(malID: id, response: response.sites))
                case .failure(_):
                    break
                }
            }
        }
    }

    struct SetAnime: Action {
        let malID: Int
        let response: MALSyncAPIMALSites
    }
}
