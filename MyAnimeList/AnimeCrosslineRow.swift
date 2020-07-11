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
    let anime: Anime
    var body: some View {
        Button(action: {
            print(anime.title)
        }, label: {
            Text(anime.title)
        })
    }
}

struct AnimeCrosslineRow_Previews: PreviewProvider {
    static var previews: some View {
        AnimeCrosslineRow(
            title: "Title",
            animes: [
                Anime(id: 1, title: "First"),
                Anime(id: 2, title: "Second"),
                Anime(id: 3, title: "Third")
            ]
        )
    }
}
