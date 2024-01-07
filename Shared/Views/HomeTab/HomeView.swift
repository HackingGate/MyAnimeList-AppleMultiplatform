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

    private var topAnimeTvBypopularity: [JikanAPIAnime]? {
        store.state.jikanState.topAnimeTvBypopularity?.data
    }
    private var topAnimeTvAiring: [JikanAPIAnime]? {
        store.state.jikanState.topAnimeTvAiring?.data
    }
    private var topAnimeMovieBypopularity: [JikanAPIAnime]? {
        store.state.jikanState.topAnimeMovieBypopularity?.data
    }
    private var topAnimeMovieAiring: [JikanAPIAnime]? {
        store.state.jikanState.topAnimeMovieAiring?.data
    }

    var body: some View {
        NavigationViewIOS(viewBuilder: {
            ScrollView(.vertical, showsIndicators: false) {
                // TODO: Add ForEach here
                LazyVStack {
                    AnimeCrosslineRow(
                        title: "Most Popular TV",
                        animes: topAnimeTvBypopularity
                    )
                    AnimeCrosslineRow(
                        title: "Top Airing TV",
                        animes: topAnimeTvAiring
                    )
                    AnimeCrosslineRow(
                        title: "Most Popular Movie",
                        animes: topAnimeMovieBypopularity
                    )
                    AnimeCrosslineRow(
                        title: "Top Airing Movie",
                        animes: topAnimeMovieAiring
                    )
                }
            }
        }, title: "Home")
        .onAppear {
            store.dispatch(action: JikanActions.Top(type: .tv,
                                                    filter: .bypopularity,
                                                    page: 1))
            store.dispatch(action: JikanActions.Top(type: .tv,
                                                    filter: .airing,
                                                    page: 1))
            store.dispatch(action: JikanActions.Top(type: .movie,
                                                    filter: .bypopularity,
                                                    page: 1))
            store.dispatch(action: JikanActions.Top(type: .movie,
                                                    filter: .airing,
                                                    page: 1))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
