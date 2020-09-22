//
//  MyTabView.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/09.
//

import SwiftUI

struct MyTabView : View {
    var body: some View {
        TabView() {
            HomeView()
                .tabItem {
                    Text("Home")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass").font(.system(size: 32, weight: .bold))
                }
        }
        .onAppear() {
            store.dispatch(action: CRActions.StartSession())
            // for testing
            store.dispatch(action: JikanActions.Anime(id: 1, request: .all, params: nil))
            store.dispatch(action: JikanActions.Top(type: .anime, page: 1, subtype: .airing, params: nil))
        }
    }
}

struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}
