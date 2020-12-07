//
//  AnimeDetailView.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import SwiftUI
import SwiftUIFlux
import AVKit
import JikanSwift
import MALSyncSwift

struct AnimeDetailView: View {
    @EnvironmentObject var store: Store<AppState>
    
    let anime: JikanAPIAnime
    
    var sites: MALSyncAPIMALSites? {
        if let sites = store.state.malSyncState.malIDSites[anime.id] {
            return sites
        }
        return nil
    }
    
    var malSyncCRArray: [MALSyncMALSiteType1] {
        if let sites = sites,
           let crunchyroll = sites.crunchyroll {
            return crunchyroll.array
        }
        return []
    }
    
    var malSyncCRMediaIds: [String: Int] {
        var result = [String: Int]()
        for malSyncCR in malSyncCRArray {
            if let queryItems = URLComponents(string: malSyncCR.url)?.queryItems {
                for item in queryItems {
                    if item.name == "media_id",
                       let value = item.value,
                       let mediaId = Int(value) {
                        result[malSyncCR.id] = mediaId
                    }
                }
            }
        }
        return result
    }
    
    var malSyncCRMediaIdsCollectionIds: [Int: Int] {
        var result = [Int: Int]()
        for malSyncCRMediaId in malSyncCRMediaIds {
            if let collectionId = store.state.crState.mediaIdToCollectionId[malSyncCRMediaId.value] {
                result[malSyncCRMediaId.value] = collectionId
            }
        }
        return result
    }
    
    var body: some View {
        List {
            // MALSync -> Crunchyroll mapper mached
            ForEach(malSyncCRArray) { malSyncCR in
                if let mediaId = malSyncCRMediaIds[malSyncCR.id] {
                    Text(malSyncCR.title)
                        .onAppear () {
                            if let session = store.state.crState.session {
                                // fetch CRAPIInfo to know collectionId
                                store.dispatch(action: CRActions.Info(sessionId: session.id, mediaId: mediaId))
                            }
                        }
                    if let collectionId = malSyncCRMediaIdsCollectionIds[mediaId] {
                        ScrollView(.horizontal) {
                            EpisodeListView(collectionId: collectionId)
                        }
                    }
                }
            }
        }
    }
}
