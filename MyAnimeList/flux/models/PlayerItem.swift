//
//  PlayerItem.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/12.
//

import Foundation

struct PlayerItem: Codable {
    let currentTime: Float64
    let duration: Float64
    
    func progress() -> Float64 {
        return currentTime / duration
    }
}
