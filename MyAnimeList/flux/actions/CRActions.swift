//
//  CRActions.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import Foundation
import SwiftUIFlux

struct CRActions {
    
    // MARK: - Requests
    
    struct StartSession: AsyncAction {
        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            CRUnblockerService.shared.GET(
                endpoint: .startSession,
                params: nil)
            {
                (result: Result<CRUnblockerResponse<CRUnblockerStartSession>, CRUnblockerService.APIError>) in
                switch result {
                case let .success(response):
                    dispatch(SetSession(response: response))
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
                "series_id": String(seriesId),
            ]
            
            CRAPIService.shared.GET(
                endpoint: .listCollections,
                params: params)
            {
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
        
        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            
            let params = [
                "session_id": sessionId,
                "collection_id": String(collectionId),
                "include_clips": "0",
                "fields": "media.media_id,media.collection_id,media.collection_name,media.series_id,media.episode_number,media.name,media.series_name,media.description,media.premium_only,media.url"
            ]
            
            CRAPIService.shared.GET(
                endpoint: .listMedia,
                params: params)
            {
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
        
        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            
            let params = [
                "session_id": sessionId,
                "fields": "media.stream_data,media.media_id",
                "media_id": String(mediaId)
            ]
            
            CRAPIService.shared.GET(
                endpoint: .info,
                params: params)
            {
                (result: Result<CRAPIResponse<CRAPIInfo>, CRAPIService.APIError>) in
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
        let response: CRUnblockerResponse<CRUnblockerStartSession>
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
        let response: CRAPIResponse<CRAPIInfo>
    }
}
