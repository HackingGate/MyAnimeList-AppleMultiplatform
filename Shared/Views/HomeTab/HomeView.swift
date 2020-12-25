//
//  HomeView.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/09.
//

import SwiftUI
import SwiftUIFlux
import JikanSwift

struct HomeView: View {
    @EnvironmentObject private var store: Store<AppState>
    
    private var topBypopularity: [JikanAPIAnime]? {
        store.state.jikanState.topBypopularity?.top
    }
    private var topAiring: [JikanAPIAnime]? {
        store.state.jikanState.topAiring?.top
    }
    private var topTv: [JikanAPIAnime]? {
        store.state.jikanState.topTv?.top
    }
    
    var body: some View {
        NavigationViewIOS(viewBuilder: {
            ScrollView(.vertical, showsIndicators: false) {
                // TODO: Add ForEach here
                if let topBypopularity = topBypopularity {
                    AnimeCrosslineRow(
                        title: "Most Popular",
                        animes: topBypopularity
                    )
                }
                if let topAiring = topAiring {
                    AnimeCrosslineRow(
                        title: "Top Airing",
                        animes: topAiring
                    )
                }
                if let topTv = topTv {
                    AnimeCrosslineRow(
                        title: "Top TV Series",
                        animes: topTv
                    )
                }
            }
        }, title: "Home")
        .onAppear() {
            store.dispatch(action: JikanActions.Top(type: .anime,
                                                    page: 1,
                                                    subtype: .bypopularity))
            store.dispatch(action: JikanActions.Top(type: .anime,
                                                    page: 1,
                                                    subtype: .airing))
            store.dispatch(action: JikanActions.Top(type: .anime,
                                                    page: 1,
                                                    subtype: .tv))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
