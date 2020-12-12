//
//  MALPosterView.swift
//  MyAnimeList (iOS)
//
//  Created by HG on 2020/12/12.
//

import SwiftUI
import JikanSwift

struct MALPosterView: View {
    @State var isShowingDetailView = false
    
    let anime: JikanAPIAnime
    var body: some View {
        VStack {
            NavigationLink(destination: AnimeDetailView(anime: anime).environmentObject(store), isActive: $isShowingDetailView) {
                EmptyView()
            }
            Button(action: {
                displayAction()
            }) {
                MALPosterItem(title: anime.title, imageURL: anime.imageURL)
                    .frame(width: 100.0, height: 212.0)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
