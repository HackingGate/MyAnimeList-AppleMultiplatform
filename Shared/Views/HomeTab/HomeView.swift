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
    
    private var topBypopularity: [JikanAPIAnime] {
        store.state.jikanState.topBypopularity?.top ?? []
    }
    private var topAiring: [JikanAPIAnime] {
        store.state.jikanState.topAiring?.top ?? []
    }
    private var topTv: [JikanAPIAnime] {
        store.state.jikanState.topTv?.top ?? []
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                // TODO: Add ForEach here
                AnimeCrosslineRow(
                    title: "Most Popular",
                    animes: topBypopularity
                )
                .onAppear() {
                    store.dispatch(action: JikanActions.Top(type: .anime, page: 1, subtype: .bypopularity, params: nil))
                }
                AnimeCrosslineRow(
                    title: "Top Airing",
                    animes: topAiring
                )
                .onAppear() {
                    store.dispatch(action: JikanActions.Top(type: .anime, page: 1, subtype: .airing, params: nil))
                }
                AnimeCrosslineRow(
                    title: "Top TV Series",
                    animes: topTv
                )
                .onAppear() {
                    store.dispatch(action: JikanActions.Top(type: .anime, page: 1, subtype: .tv, params: nil))
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
