//
//  AnimeDetailView.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import SwiftUI
import SwiftUIFlux
import AVKit

struct AnimeDetailView: View {
    @EnvironmentObject var store: Store<AppState>
    
    let anime: CRAnime
    
    var episodes: [CRAPIEpisode] {
        return store.state.crState.collections[anime.collectionId] ?? []
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
            if (!episode.premiumOnly) {
                if let streamData = episode.streamData,
                   let adaptive = streamData.streams.last(where: { $0.quality == "adaptive" }) ?? streamData.streams.last,
                   let url = URL(string: adaptive.url),
                   let episodeId = Int(episode.id) {
                    FullscreenVideoPlayer(episodeId: episodeId, streamURL: url)
                } else {
                    Text("Streams current not avaliable")
                }
            } else {
                Text("Subscribe Crunchyroll Premium to watch this episode")
            }
        }
    }
}

struct AnimeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeDetailView(anime: CRAnime(id: 1, title: "First", seriesId: 1, collectionId: 1))
    }
}
