//
//  AnimeDetailView.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import SwiftUI
import AVKit

struct AnimeDetailView: View {
    let anime: Anime
    
    var episodes: [CRAPIEpisode] {
        return store.state.animesState.collections[anime.collectionId] ?? []
    }
    
    var body: some View {
        List {
            Text(anime.title)
            ScrollView(.horizontal) {
                LazyHStack(alignment: .center, spacing: 20) {
                    ForEach(episodes) {
                        EpisodeView(episode: $0)
                    }
                }
            }
        }
    }
}

struct EpisodeView: View {
    @State var modalDisplayed = false
    
    let episode: CRAPIEpisode
    var body: some View {
        Button(action: {
            self.modalDisplayed = true
        }, label: {
            Text("\(episode.episodeNumber) \(episode.name)")
        })
        .sheet(isPresented: $modalDisplayed) {
            if let streamData = episode.streamData {
                if let adaptive = streamData.streams.first {
                    if let url = URL(string: adaptive.url) {
                        let player = AVPlayer(url: url)
                        VideoPlayer(player: player)
                    }
                }
            }
        }
    }
}

struct AnimeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeDetailView(anime: Anime(id: 1, title: "First", seriesId: 1, collectionId: 1))
    }
}
