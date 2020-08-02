//
//  AnimesActions.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import Foundation
import SwiftUIFlux

struct AnimesActions {
    
    // MARK: - Requests
    
    struct ListCollections: AsyncAction {
        let seriesId: Int

        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            
            let params = [
                "series_id": String(seriesId),
            ]
            
            CRAPIService.shared.GET(
                endpoint: .listCollections,
                params: params)
            {
                (result: Result<CRResponse<CRCollection>, CRAPIService.APIError>) in
                switch result {
                case let .success(response):
                    print(response)
                case .failure(_):
                    break
                }
            }
        }
    
    }
    
    struct ListMedia: AsyncAction {
        let collectionId: Int
        
        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            
            let params = [
                "collection_id": String(collectionId),
                "include_clips": "0",
                "fields": "media.media_id,media.collection_id,media.collection_name,media.series_id,media.episode_number,media.name,media.series_name,media.description,media.premium_only,media.url"
            ]
            
            CRAPIService.shared.GET(
                endpoint: .listMedia,
                params: params)
            {
                (result: Result<CRResponse<CRMedia>, CRAPIService.APIError>) in
                switch result {
                case let .success(response):
                    print(response)
                case .failure(_):
                    break
                }
            }
        }
    }
}
