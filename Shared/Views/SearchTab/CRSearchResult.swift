//
//  CRSearchResult.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/22.
//

import SwiftUI
import CrunchyrollSwift
import KingfisherSwiftUI

struct CRSearchResult: View {
    
    let result: [CRAPISeries]
    
    @State private var isShowingDetailView = false
    @State private var selectedSeries: CRAPISeries?
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(result) { series in
                #if os(iOS)
                NavigationLink(destination: CRCollectionView(series: $selectedSeries).environmentObject(store), isActive: $isShowingDetailView) {
                    EmptyView()
                }
                #endif
                Button(action: {
                    isShowingDetailView = true
                    selectedSeries = series
                    if let session = store.state.crState.session, let seriesId = Int(series.id) {
                        store.dispatch(action: CRActions.ListCollections(sessionId: session.id, seriesId: seriesId))
                    }
                }) {
                    HStack(alignment: .center, spacing: 20) {
                        if let imageURL = URL(string: series.portraitImage.large_url) {
                            KFImage(imageURL)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: Common().posterImage.width, height: Common().posterImage.height)
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            Text(series.name)
                                .font(.headline)
                                .lineLimit(2)
                            Text(series.description)
                                .font(.subheadline)
                                .lineLimit(4)
                        }
                    }
                    .padding()
                }
                .modify {
                    #if os(tvOS)
                    $0
                        .sheet(isPresented: $isShowingDetailView) {
                            CRCollectionView(series: $selectedSeries).environmentObject(store)
                        }
                        .buttonStyle(PlainButtonStyle())
                    #else
                    $0
                        .buttonStyle(PlainButtonStyle())
                    #endif
                }
                Divider()
            }
        }
    }
}
