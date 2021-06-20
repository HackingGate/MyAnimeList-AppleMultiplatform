//
//  CRActions.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

// Disable because Crunchyroll's parms are short
// swiftlint:disable identifier_name

import Foundation
import SwiftUIFlux
import CrunchyrollSwift

struct CRActions {

    // MARK: - Requests

    struct StartSession: AsyncAction {
        var unblock: Bool = false

        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            CRAPIService.shared.GET(
                endpoint: unblock ? .startUSSession : .startSession ,
                params: nil) {
                (result: Result<CRAPIResponse<CRAPIStartSession>, CRAPIService.APIError>) in
                switch result {
                case let .success(response):
                    dispatch(SetSession(response: response))
                case .failure(_):
                    break
                }
            }
        }
    }

    struct Autocomplete: AsyncAction {
        let sessionId: String
        let mediaTypes = "anime"
        let q: String

        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {

            let params = [
                "session_id": sessionId,
                "media_types": mediaTypes,
                "q": q
            ]

            CRAPIService.shared.GET(
                endpoint: .autocomplete,
                params: params) {
                (result: Result<CRAPIResponse<[CRAPISeries]>, CRAPIService.APIError>) in
                switch result {
                case let .success(response):
                    dispatch(SetSeries(mediaTypes: mediaTypes,
                                       q: q,
                                       response: response))
                case .failure(_):
                    break
                }
            }
        }
    }

    struct ListCollections: AsyncAction {
        let sessionId: String
        let seriesId: Int

        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {

            let params = [
                "session_id": sessionId,
                "series_id": String(seriesId)
            ]

            CRAPIService.shared.GET(
                endpoint: .listCollections,
                params: params) {
                (result: Result<CRAPIResponse<[CRAPICollection]>, CRAPIService.APIError>) in
                switch result {
                case let .success(response):
                    dispatch(SetCollections(seriesId: seriesId,
                                            response: response))
                case .failure(_):
                    break
                }
            }
        }

    }

    struct ListMedia: AsyncAction {
        let sessionId: String
        let collectionId: Int
        var fields: [CRAPIMedia.CodingKeys] = []

        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {

            let params = [
                "session_id": sessionId,
                "collection_id": String(collectionId),
                "fields": fields.map({ "media." + $0.stringValue }).joined(separator: ",")
            ]

            CRAPIService.shared.GET(
                endpoint: .listMedia,
                params: params) {
                (result: Result<CRAPIResponse<[CRAPIMedia]>, CRAPIService.APIError>) in
                switch result {
                case let .success(response):
                    dispatch(SetMedia(collectionId: collectionId,
                                      response: response))
                case .failure(_):
                    break
                }
            }
        }
    }

    struct Info: AsyncAction {
        let sessionId: String
        let mediaId: Int
        var fields: [CRAPIMedia.CodingKeys] = []

        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {

            let params = [
                "session_id": sessionId,
                "media_id": String(mediaId),
                "fields": fields.map({ "media." + $0.stringValue }).joined(separator: ",")
            ]

            CRAPIService.shared.GET(
                endpoint: .info,
                params: params) {
                (result: Result<CRAPIResponse<CRAPIMedia>, CRAPIService.APIError>) in
                switch result {
                case let .success(response):
                    dispatch(SetInfo(mediaId: mediaId,
                                     response: response))
                case .failure(_):
                    break
                }
            }
        }
    }

    struct SetSession: Action {
        let response: CRAPIResponse<CRAPIStartSession>
    }

    struct SetSeries: Action {
        let mediaTypes: String
        let q: String
        let response: CRAPIResponse<[CRAPISeries]>
    }

    struct SetCollections: Action {
        let seriesId: Int
        let response: CRAPIResponse<[CRAPICollection]>
    }

    struct SetMedia: Action {
        let collectionId: Int
        let response: CRAPIResponse<[CRAPIMedia]>
    }

    struct SetInfo: Action {
        let mediaId: Int
        let response: CRAPIResponse<CRAPIMedia>
    }
}
