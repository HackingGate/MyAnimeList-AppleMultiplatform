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
    private var topMovie: [JikanAPIAnime]? {
        store.state.jikanState.topMovie?.top
    }
    private var topOva: [JikanAPIAnime]? {
        store.state.jikanState.topOva?.top
    }
    private var topUpcoming: [JikanAPIAnime]? {
        store.state.jikanState.topUpcoming?.top
    }
    
    var body: some View {
        NavigationViewIOS(viewBuilder: {
            ScrollView(.vertical, showsIndicators: false) {
                // TODO: Add ForEach here
                LazyVStack {
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
                    if let topMovie = topMovie {
                        AnimeCrosslineRow(
                            title: "Top Movies",
                            animes: topMovie
                        )
                    }
                    if let topOva = topOva {
                        AnimeCrosslineRow(
                            title: "Top OVAs",
                            animes: topOva
                        )
                    }
                    if let topUpcoming = topUpcoming {
                        AnimeCrosslineRow(
                            title: "Top Upcoming",
                            animes: topUpcoming
                        )
                    }
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
            store.dispatch(action: JikanActions.Top(type: .anime,
                                                    page: 1,
                                                    subtype: .movie))
            store.dispatch(action: JikanActions.Top(type: .anime,
                                                    page: 1,
                                                    subtype: .ova))
            store.dispatch(action: JikanActions.Top(type: .anime,
                                                    page: 1,
                                                    subtype: .upcoming))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
