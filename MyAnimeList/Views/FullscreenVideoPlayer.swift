//
//  FullscreenVideoPlayer.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/10.
//

import SwiftUI
import SwiftUIFlux
import AVKit

struct FullscreenVideoPlayer: View {
    @EnvironmentObject var store: Store<AppState>

    let mediaId: Int
    
    var media: CRAPIMedia? {
        return store.state.crState.medias[mediaId]
    }
    
    var player: AVPlayer? {
        if let media = self.media,
           let streamData = media.streamData,
           let adaptive = streamData.streams.last(where: { $0.quality == "adaptive" }) ?? streamData.streams.last,
           let url = URL(string: adaptive.url) {
            return AVPlayer(url: url)
        }
        return nil
    }
    
    var body: some View {
        // TODO: https://www.swiftbysundell.com/tips/optional-swiftui-views/
        if ((media != nil) && !media!.premiumOnly) {
            if ((player) != nil) {
                AnimePlayer(itemId: mediaId, player: player!)
            } else {
                Text("Loading anime stream")
            }
        } else {
            Text("Subscribe Crunchyroll Premium to watch this episode")
        }
    }
}

struct AnimePlayer: View {
    let itemId: Int
    let player: AVPlayer

    var body: some View {
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
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
