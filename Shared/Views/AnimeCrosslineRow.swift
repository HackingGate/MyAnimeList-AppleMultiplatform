//
//  AnimeCrosslineRow.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/11.
//

import SwiftUI
import SwiftUIFlux
import JikanSwift
import KingfisherSwiftUI

struct AnimeCrosslineRow: View {
    let title: String
    let animes: [JikanAPIAnime]
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            Text(title)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(animes) { anime in
                        ImageTextView(data: anime,
                                      imageType: Common().posterImage) {
                            AnimeDetailView(anime: anime).environmentObject(store)
                        } action: {
                            store.dispatch(action: JikanActions.Anime(id: anime.id,
                                                                      request: .all))
                            store.dispatch(action: MALSyncActions.MALAnime(id: anime.id))
                        }
                    }
                }
                .padding(.horizontal)
            }
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
