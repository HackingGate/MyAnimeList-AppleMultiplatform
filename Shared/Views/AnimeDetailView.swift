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
import CrunchyrollSwift

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

    // 1: Map MalSync to query string
    private var malSyncCRURLLastPathComponent: [String: String] {
        var result = [String: String]()
        for malSyncCR in malSyncCRArray {
            if let url = URL(string: malSyncCR.url) {
                result[malSyncCR.id] = url.lastPathComponent
            }
        }
        return result
    }

    // 2: Map MalSync to Int(CRSeries.frist.id)
    private var malSyncCRSeries: [String: CRAPISeries] {
        var result = [String: CRAPISeries]()
        for malSyncCR in malSyncCRArray {
            if let crURLLastPathComponet = malSyncCRURLLastPathComponent[malSyncCR.id] {
                // Only use first result of the search results
                if let crSeries0 = store.state.crState.queries[crURLLastPathComponet]?.first {
                    result[malSyncCR.id] = crSeries0
                }
            }
        }
        return result
    }

    // 3: Map MalSync to CRCollections
    private var malSyncCRCollections: [String: CRAPICollection] {
        var result = [String: CRAPICollection]()
        for malSyncCR in malSyncCRArray {
            if let crSeries = malSyncCRSeries[malSyncCR.id], let seriesId = Int(crSeries.id) {
                if let collections = store.state.crState.series[seriesId] {
                    let filtered = collections.filter { (crCollection) -> Bool in
                        crCollection.name == malSyncCR.title
                    }
                    if let filtered0 = filtered.first {
                        result[malSyncCR.id] = filtered0
                    }
                }
            }
        }
        return result
    }

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading) {
                HStack(alignment: .center, spacing: 20) {
                    AnimeInformationView(animeDetail: animeDetail)
                }
                .padding()
                Divider()
                // MALSync -> Crunchyroll mapper mached
                ForEach(malSyncCRArray) { malSyncCR in
                    if let crCollection = malSyncCRCollections[malSyncCR.id], let collectionId = Int(crCollection.id) {
                        // 3
                        Text("Found \"\(malSyncCR.title)\":")
                        EpisodeListView(collectionId: collectionId)
                    } else if let crSeries = malSyncCRSeries[malSyncCR.id] {
                        // 2
                        // TODO: unable to match Collection with MalSync.title
                        // Example:
                        // `curl https://api.malsync.moe/mal/anime/16498 | jq`
                        // "Shingeki no Kyojin" in MalSync.title not match "Attack on Titan" in CRCollection.name
                        // `curl https://api.malsync.moe/mal/anime/25777 | jq`
                        // "Shingeki no Kyojin 2" in MalSync.title not match "Attack on Titan Season 2" in CRCollection.name
                        // Will display all CRCollections if no match
                        // TODO: determin (Subtitled),(Dubbed),(English Dub),(Sub),etc
                        Text("Unable to find \"\(malSyncCR.title)\", listing all seasons:")
                            .onAppear {
                                if let session = store.state.crState.session, let seriesId = Int(crSeries.id) {
                                    store.dispatch(action: CRActions.ListCollections(sessionId: session.id, seriesId: seriesId))
                                }
                            }
                        CRCollectionView(series: crSeries).environmentObject(store)
                    } else if let crURLLastPathComponet = malSyncCRURLLastPathComponent[malSyncCR.id] {
                        // 1
                        // TODO: unable to autocomplete some keywords
                        // Example:
                        // `curl https://api.malsync.moe/mal/anime/9253 | jq`
                        // URL is http://www.crunchyroll.com/steinsgate
                        // Unable to autocomplete "steinsgate"
                        // But keyword Steins;Gate works
                        Text("Finding \"\(malSyncCR.title)\"")
                            .onAppear {
                                if let session = store.state.crState.session {
                                    store.dispatch(action: CRActions.Autocomplete(sessionId: session.id, q: crURLLastPathComponet))
                                }
                            }
                    } else {
                        Text("Unable to find \"\(malSyncCR.title)\", listing all seasons:")
                    }
                }
            }
        }
        .navigationTitle(anime.title)
    }
}
