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
        NavigationView {
            ScrollView(.vertical) {
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
            .navigationTitle("Home")
        }
        .onAppear() {
            store.dispatch(action: JikanActions.Top(type: .anime, page: 1, subtype: .bypopularity, params: nil))
            store.dispatch(action: JikanActions.Top(type: .anime, page: 1, subtype: .airing, params: nil))
            store.dispatch(action: JikanActions.Top(type: .anime, page: 1, subtype: .tv, params: nil))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
