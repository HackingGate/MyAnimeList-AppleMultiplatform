//
//  MALPosterView.swift
//  MyAnimeList (iOS)
//
//  Created by HG on 2020/12/12.
//

import SwiftUI
import JikanSwift

struct MALPosterView: View {
    let anime: JikanAPIAnime
    var imageWidth: CGFloat = 100.0
    var imageHeight: CGFloat {
        imageWidth * 1.5
    }
    
    @State var isShowingDetailView = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: AnimeDetailView(anime: anime).environmentObject(store), isActive: $isShowingDetailView) {
                EmptyView()
            }
            Button(action: {
                displayAction()
            }) {
                MALPosterItem(title: anime.title, imageURL: anime.imageURL)
                    .frame(width: imageWidth, height: imageHeight + 62)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
