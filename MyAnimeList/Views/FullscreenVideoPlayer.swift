//
//  FullscreenVideoPlayer.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/10.
//

import SwiftUI
import AVKit

struct FullscreenVideoPlayer: View {
    let streamURL: URL
    
    var body: some View {
        let player = AVPlayer(url: streamURL)
        VideoPlayer(player: player)
            .edgesIgnoringSafeArea(.all)
    }
}

struct FullscreenVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        FullscreenVideoPlayer(streamURL: URL(string: "https://bit.ly/swswift")!)
    }
}
