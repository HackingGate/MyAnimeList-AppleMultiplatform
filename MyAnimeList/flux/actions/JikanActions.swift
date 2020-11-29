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
        let params: [String: String]?
        
        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            JikanAPIService.shared.loadAnime(
                id: id,
                request: request,
                params: params)
            {
                (result: Result<JikanAPIAnime, JikanAPIService.APIError>) in
                switch result {
                case let .success(response):
                    #if DEBUG
                    print(response)
                    #endif
                    dispatch(SetAnime(malID: 1, response: response))
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
        let params: [String: String]?

        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            JikanAPIService.shared.loadTop(
                type: type,
                page: page,
                subtype: subtype,
                params: nil)
            {
                (result: Result<JikanAPITop<[JikanAPIAnime]>, JikanAPIService.APIError>) in
                switch result {
                case let .success(response):
                    #if DEBUG
                    print(response)
                    #endif
                    dispatch(SetTop(page: page, response: response))
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
        let response: JikanAPITop<[JikanAPIAnime]>
    }
}
