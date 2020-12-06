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
import CrunchyrollSwiftWeb
import CrunchyrollSwift
import MALSyncSwift

struct AnimeDetailView: View {
    @EnvironmentObject var store: Store<AppState>
    
    let anime: JikanAPIAnime
    
    var sites: MALSyncMALSites? {
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
    
    var collections: [CRAPICollection] {
        if let seriesId = store.state.jikanCRState.malIdSeriesId[anime.id] {
            return store.state.crState.series[seriesId] ?? []
        }
        return []
    }
    
    var body: some View {
        List {
            if malSyncCRMediaIds.count > 0 {
                // MALSync -> Crunchyroll mapper mached
                ForEach(malSyncCRArray) { malSyncCR in
                    if let mediaId = malSyncCRMediaIds[malSyncCR.id] {
                        Text(malSyncCR.title)
                            .onAppear() {
                                if let session = store.state.crState.session {
                                    // Need to know collectionId
                                    store.dispatch(action: CRActions.Info(sessionId: session.id, mediaId: mediaId))
                                }
                            }
                    }
                }
            } else {
                ForEach(collections) { collection in
                    Text(collection.name)
                    ScrollView(.horizontal) {
                        if let collectionId = Int(collection.id) {
                            EpisodeListView(collectionId: collectionId)
                        }
                    }
                }
            }
        }
    }
}
