//
//  FullscreenVideoPlayer.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/10.
//

import SwiftUI
import AVKit

struct FullscreenVideoPlayer: View {    
    let episodeId: Int
    let streamURL: URL
    
    var body: some View {
        let player = AVPlayer(url: streamURL)
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                if let playerItem = store.state.playState.playerItems[episodeId] {
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
                    store.dispatch(action: PlayActions.SavePlayerItem(mediaId: episodeId,
                                                                        playerItem: playerItem))
                }
            }
    }
}

struct FullscreenVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        FullscreenVideoPlayer(episodeId: 0, streamURL: URL(string: "https://bit.ly/swswift")!)
    }
}
