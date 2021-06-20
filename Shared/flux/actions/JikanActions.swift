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
            JikanAPIService.shared.loadAnime(
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
        let page: Int
        let subtype: JikanAPITopSubtype
        var params: [String: String] = [:]

        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            JikanAPIService.shared.loadTop(
                type: type,
                page: page,
                subtype: subtype,
                params: params) {
                (result: Result<JikanAPITop<[JikanAPIAnime]>, JikanAPIService.APIError>) in
                switch result {
                case let .success(response):
                    dispatch(SetTop(page: page, subtype: subtype, response: response))
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
        let subtype: JikanAPITopSubtype
        let response: JikanAPITop<[JikanAPIAnime]>
    }
}
