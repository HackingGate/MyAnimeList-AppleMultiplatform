//
//  MainTabView.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/09.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "display")
                    Text("Home")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            store.dispatch(action: CRActions.StartSession(unblock: true))
        }
    }
}

struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
