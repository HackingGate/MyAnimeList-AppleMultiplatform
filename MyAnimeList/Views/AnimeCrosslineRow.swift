//
//  AnimeCrosslineRow.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/11.
//

import SwiftUI

struct AnimeCrosslineRow: View {
    let title: String
    let animes: [Anime]
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 32) {
                    ForEach(self.animes) { anime in
                        AnimeDetailRowItem(anime: anime)
                    }
                }.padding(.leading)
            }
        }
    }
}

struct AnimeDetailRowItem: View {
    @State var modalDisplayed = false

    let anime: Anime
    var body: some View {
        Button(action: {
            if let session = store.state.animesState.session {
                store.dispatch(action: AnimesActions.ListCollections(sessionId: session.id,
                                                                     seriesId: anime.seriesId))
                store.dispatch(action: AnimesActions.ListMedia(sessionId: session.id,
                                                               collectionId: anime.collectionId))
                self.modalDisplayed = true
            }
        }, label: {
            Text(anime.title)
        })
        .sheet(isPresented: $modalDisplayed) {
            AnimeDetailView(anime: anime).environmentObject(store)
        }
    }
}

struct AnimeCrosslineRow_Previews: PreviewProvider {
    static var previews: some View {
        AnimeCrosslineRow(
            title: "Title",
            animes: [
                Anime(id: 1, title: "First", seriesId: 1, collectionId: 1),
                Anime(id: 2, title: "Second", seriesId: 2, collectionId: 2),
                Anime(id: 3, title: "Third", seriesId: 3, collectionId: 3)
            ]
        )
    }
}
