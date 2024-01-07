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
        let id: Int
        let request: JikanAPIAnimeRequest
        var params: [String: String] = [:]

        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            JikanAPIService.shared.getAnimeFull(
                id: id,
                request: request,
                params: params) {
                (result: Result<JikanAPIAnime, JikanAPIService.APIError>) in
                switch result {
                case let .success(response):
                    dispatch(SetAnime(malID: id, response: response))
                case .failure(_):
                    break
                }
            }
        }
    }

    struct Top: AsyncAction {
        let type: JikanAPITopType
        let filter: JikanAPITopFilter
        let page: Int
        var params: [String: String] = [:]

        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            JikanAPIService.shared.getTopAnime(
                type: type,
                filter: filter,
                page: page,
                params: params) {
                (result: Result<JikanAPITop<[JikanAPIAnime]>, JikanAPIService.APIError>) in
                switch result {
                case let .success(response):
                    dispatch(SetTop(page: page, filter: filter, type: type, response: response))
                case .failure(_):
                    break
                }
            }
        }
    }

    struct SetAnime: Action {
        let malID: Int
        let response: JikanAPIAnime
    }

    struct SetTop: Action {
        let page: Int
        let filter: JikanAPITopFilter
        let type: JikanAPITopType
        let response: JikanAPITop<[JikanAPIAnime]>
    }
}
