//
//  CRCollectionView.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/22.
//

import SwiftUI
import SwiftUIFlux
import CrunchyrollSwift

struct CRCollectionView: View {
    @EnvironmentObject private var store: Store<AppState>
    
    @Binding var series: CRAPISeries?
    
    private var crCollections: [CRAPICollection]? {
        if let series = series, let seriesId = Int(series.id), let collections = store.state.crState.series[seriesId] {
            return collections
        }
        return nil
    }
    
    var body: some View {
        if let series = series {
            ScrollView(.vertical) {
                if let collections = crCollections {
                    LazyVStack(alignment: .leading) {
                        ForEach(collections) { collection in
                            LazyVStack(alignment: .leading) {
                                Text(collection.name)
                                    .padding(.leading)
                                if let collectionId = Int(collection.id) {
                                    EpisodeListView(collectionId: collectionId)
                                }
                                Divider()
                            }
                        }
                    }
                }
            }
            .navigationTitle(series.name)
        }
    }
}
