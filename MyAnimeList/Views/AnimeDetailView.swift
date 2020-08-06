//
//  AnimeDetailView.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import SwiftUI

struct AnimeDetailView: View {
    let anime: Anime
    var body: some View {
        List {
            Text(anime.title)
            ScrollView(.horizontal) {
                LazyHStack(alignment: .center, spacing: 20) {
                    ForEach(1...12, id: \.self) {
                        EpisodeView(index: $0)
                    }
                }
            }
            .onAppear {
                store.dispatch(action: AnimesActions.StartSession())
//                store.dispatch(action: AnimesActions.ListCollections(seriesId: anime.seriesId))
//                store.dispatch(action: AnimesActions.ListMedia(collectionId: anime.collectionId))
            }
        }
    }
}

struct EpisodeView: View {
    let index: Int
    var body: some View {
        Button(action: {
            print("Episode \(index)")
        }, label: {
            Text("Episode \(index)")
        })
    }
}

struct AnimeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeDetailView(anime: Anime(id: 1, title: "First", seriesId: 1, collectionId: 1))
    }
}
