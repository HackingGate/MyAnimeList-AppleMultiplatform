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

struct AnimeDetailView: View {
    @EnvironmentObject var store: Store<AppState>
    
    let anime: JikanAPIAnime
    
    var collections: [CRAPICollection] {
        if let seriesId = store.state.jikanCRState.malIdSeriesId[anime.id] {
            return store.state.crState.series[seriesId] ?? []
        }
        return []
    }
    
    var body: some View {
        List {
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
