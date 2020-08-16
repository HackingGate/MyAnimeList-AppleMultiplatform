//
//  AnimeDetailView.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import SwiftUI
import SwiftUIFlux
import AVKit
import CrunchyrollSwift

struct AnimeDetailView: View {
    @EnvironmentObject var store: Store<AppState>
    
    let anime: CRAnime
    
    var episodes: [CRAPIMedia] {
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
    
    let episode: CRAPIMedia
    var body: some View {
        Button(action: {
            self.modalDisplayed = true
            if let episodeId = Int(episode.id), let session = store.state.crState.session {
                store.dispatch(action: CRActions.Info(sessionId: session.id, mediaId: episodeId))
            }
        }, label: {
            Text("\(episode.episodeNumber) \(episode.name)")
        })
        .sheet(isPresented: $modalDisplayed) {
            if let mediaId = Int(episode.id) {
                FullscreenVideoPlayer(mediaId: mediaId)
            }
        }
    }
}

struct AnimeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeDetailView(anime: CRAnime(id: 1, title: "First", seriesId: 1, collectionId: 1))
    }
}
