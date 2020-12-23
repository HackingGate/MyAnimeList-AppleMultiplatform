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
    
    let series: CRAPISeries
    
    private var crCollections: [CRAPICollection]? {
        if let seriesId = Int(series.id), let collections = store.state.crState.series[seriesId] {
            return collections
        }
        return nil
    }
    
    var body: some View {
        ScrollView(.vertical) {
            if let collections = crCollections {
                LazyVStack(alignment: .leading) {
                    ForEach(collections) { collection in
                        VStack {
                            Text(collection.name)
                                .padding(.leading)
                            if let collectionId = Int(collection.id) {
                                EpisodeListView(collectionId: collectionId)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(series.name)
    }
}
