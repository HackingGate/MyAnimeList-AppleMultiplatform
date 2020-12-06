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
            { (result: Result<MALSyncMAL, MALSyncAPIService.APIError>) in
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
