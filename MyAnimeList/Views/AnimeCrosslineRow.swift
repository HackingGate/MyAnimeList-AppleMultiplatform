//
//  AnimeCrosslineRow.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/11.
//

import SwiftUI
import SwiftUIFlux
import JikanSwift

struct AnimeCrosslineRow: View {
    let title: String
    let animes: [JikanAPIAnime]
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

    let anime: JikanAPIAnime
    var body: some View {
        Button(action: {
            if let session = store.state.crState.session {
//                store.dispatch(action: CRActions.ListCollections(sessionId: session.id,
//                                                                     seriesId: anime.seriesId))
//                store.dispatch(action: CRActions.ListMedia(sessionId: session.id,
//                                                               collectionId: anime.collectionId))
                self.modalDisplayed = true
            }
        }, label: {
            Text(anime.title)
        })
        .sheet(isPresented: $modalDisplayed) {
//            AnimeDetailView(anime: anime).environmentObject(store)
        }
    }
}

struct AnimeCrosslineRow_Previews: PreviewProvider {
    static var previews: some View {
        AnimeCrosslineRow(
            title: "Title",
            animes: []
        )
    }
}
