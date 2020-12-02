//
//  AnimeEpisodeListView.swift
//  MyAnimeList
//
//  Created by HG on 2020/09/22.
//

import SwiftUI
import SwiftUIFlux
import CrunchyrollSwift

struct EpisodeListView: View {
    @EnvironmentObject var store: Store<AppState>
    
    let collectionId: Int
    
    var episodes: [CRAPIMedia] {
        return store.state.crState.collections[collectionId] ?? []
    }
    
    var body: some View {
        LazyHStack(alignment: .center, spacing: 20) {
            ForEach(episodes) {
                if let mediaId = Int($0.id) {
                    EpisodeView(episode: $0, mediaId: mediaId)
                }
            }
        }
        .onAppear() {
            if let session = store.state.crState.session {
                if (episodes.count == 0) {
                    // Request only when data not yet avaliable
                    store.dispatch(action: CRActions.ListMedia(sessionId: session.id, collectionId: collectionId))
                }
            }
        }
    }
}

struct EpisodeView: View {
    @State var modalDisplayed = false
    
    let episode: CRAPIMedia
    let mediaId: Int
    var body: some View {
        #if canImport(UIKit)
        Button(action: {
            displayAction()
        }, label: {
            Text("\(episode.episodeNumber) \(episode.name)")
        })
        .fullScreenCover(isPresented: $modalDisplayed) {
            FullscreenVideoPlayer(mediaId: mediaId).environmentObject(store)
        }
        #else
        Button(action: {
            displayAction()
        }, label: {
            Text("\(episode.episodeNumber) \(episode.name)")
        })
        .sheet(isPresented: $modalDisplayed) {
            FullscreenVideoPlayer(mediaId: mediaId).environmentObject(store)
        }
        #endif
    }

    func displayAction() {
        self.modalDisplayed = true
        if let episodeId = Int(episode.id), let session = store.state.crState.session {
            store.dispatch(action: CRActions.Info(sessionId: session.id, mediaId: episodeId))
        }
    }
}
