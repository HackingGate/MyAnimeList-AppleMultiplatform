//
//  AnimeDetailView.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import SwiftUI

struct AnimeDetailView: View {
    let title: String
    var body: some View {
        List {
            Text(title)
            ScrollView(.horizontal) {
                LazyHStack(alignment: .center, spacing: 20) {
                    ForEach(1...12, id: \.self) {
                        EpisodeView(index: $0)
                    }
                }
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
        AnimeDetailView(title: "Anime Title")
    }
}
