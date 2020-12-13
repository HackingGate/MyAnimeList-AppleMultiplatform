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
import KingfisherSwiftUI

struct AnimeDetailView: View {
    @EnvironmentObject private var store: Store<AppState>
    
    let anime: JikanAPIAnime
    
    private var animeDetail: JikanAPIAnime {
        store.state.jikanState.animes[anime.id] ?? anime
    }
    
    private var sites: MALSyncAPIMALSites? {
        if let sites = store.state.malSyncState.malIDSites[anime.id] {
            return sites
        }
        return nil
    }
    
    private var malSyncCRArray: [MALSyncMALSiteType1] {
        if let sites = sites,
           let crunchyroll = sites.crunchyroll {
            return crunchyroll.array
        }
        return []
    }
    
    private var malSyncCRMediaIds: [String: Int] {
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
    
    private var malSyncCRMediaIdsCollectionIds: [Int: Int] {
        var result = [Int: Int]()
        for malSyncCRMediaId in malSyncCRMediaIds {
            if let collectionId = store.state.crState.mediaIdToCollectionId[malSyncCRMediaId.value] {
                result[malSyncCRMediaId.value] = collectionId
            }
        }
        return result
    }
    
    @ViewBuilder
    var informationView: some View {
        HStack(alignment: .center, spacing: 20) {
            VStack(alignment: .leading, spacing: 20) {
                #if os(tvOS)
                Text(anime.title)
                    .font(.title)
                #endif
                if let titleJapanese = animeDetail.titleJapanese {
                    Text(titleJapanese)
                        .font(.title)
                }
                if let synopsis = animeDetail.synopsis {
                    Text(synopsis)
                        .font(.body)
                        .lineLimit(4)
                }
            }
            Spacer()
            if let imageURL = URL(string: anime.imageURL) {
                KFImage(imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Common.PosterImage.width, height: Common.PosterImage.heigth)
            }
        }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                informationView
                Divider()
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
                            EpisodeListView(collectionId: collectionId)
                        }
                    }
                }
            }
        }
        .navigationTitle(anime.title)
    }
}
