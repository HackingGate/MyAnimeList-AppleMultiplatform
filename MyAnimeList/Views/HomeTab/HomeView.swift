//
//  HomeView.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/09.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical) {
            // TODO: Add ForEach here
            AnimeCrosslineRow(
                title: "Top Airing",
                animes: [
                    Anime(id: 1, title: "Re:Zero kara Hajimeru Isekai Seikatsu 2nd Season"),
                    Anime(id: 2, title: "Yahari Ore no Seishun Love Comedy wa Machigatteiru. Kan"),
                    Anime(id: 3, title: "Sword Art Online: Alicization - War of Underworld 2nd Season"),
                ]
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}