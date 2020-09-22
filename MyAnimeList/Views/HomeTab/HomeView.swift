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
    @EnvironmentObject var store: Store<AppState>
    
    var top: [JikanAPIAnime] {
        return store.state.jikanState.top?.top ?? []
    }
    
    var body: some View {
        ScrollView(.vertical) {
            // TODO: Add ForEach here
            AnimeCrosslineRow(
                title: "Top Airing",
                animes: top
            )
        }
        .onAppear() {
            store.dispatch(action: JikanActions.Top(type: .anime, page: 1, subtype: .airing, params: nil))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
