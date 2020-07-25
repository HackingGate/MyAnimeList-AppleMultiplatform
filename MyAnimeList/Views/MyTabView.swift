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
    }
}

struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}
