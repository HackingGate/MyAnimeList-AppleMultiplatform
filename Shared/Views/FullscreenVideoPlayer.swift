//
//  FullscreenVideoPlayer.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/10.
//

import SwiftUI
import SwiftUIFlux
import AVKit
import CrunchyrollSwift

struct FullscreenVideoPlayer: View {
    @EnvironmentObject private var store: Store<AppState>

    let mediaId: Int
    
    private var media: CRAPIMedia? {
        return store.state.crState.medias[mediaId]
    }
    
    @State private var player: AVPlayer?
    
    var body: some View {
        if let media = media, let premiumOnly = media.premiumOnly, !premiumOnly {
            if let player = player {
                AnimePlayer(itemId: mediaId, player: player)
            } else if let streamData = media.streamData,
                      let adaptive = streamData.streams.last(where: { $0.quality == "adaptive" }) ?? streamData.streams.last,
                      let url = URL(string: adaptive.url) {
                Text("Loaded")
                    .onAppear() {
                        player = AVPlayer(url: url)
                    }
            } else {
                Text("Loading anime stream")
                CloseButton()
            }
        } else {
            Text("Subscribe Crunchyroll Premium to watch this episode")
            CloseButton()
        }
    }
}

struct CloseButton: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        #if os(tvOS)
        EmptyView()
        #else
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Dismiss")
        }
        .padding()
        #endif
    }
}

struct AnimePlayer: View {
    let itemId: Int
    let player: AVPlayer

    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onAppear() {
                if let playerItem = store.state.playState.playerItems[itemId] {
                    let timeToSeek = CMTime(seconds: playerItem.currentTime, preferredTimescale: 1)
                    player.seek(to: timeToSeek)
                }
                player.play()
            }
            .onDisappear() {
                if let item = player.currentItem {
                    let currentTime = CMTimeGetSeconds(item.currentTime())
                    let duration = CMTimeGetSeconds(item.duration)
                    let playerItem = PlayerItem(currentTime: currentTime, duration: duration)
                    store.dispatch(action: PlayActions.SavePlayerItem(mediaId: itemId,
                                                                        playerItem: playerItem))
                }
            }
    }
}
