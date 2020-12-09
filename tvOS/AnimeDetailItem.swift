//
//  AnimeDetailItem.swift
//  MyAnimeList (tvOS)
//
//  Created by HG on 2020/12/09.
//

import SwiftUI
import JikanSwift
import KingfisherSwiftUI

struct AnimeDetailItem: View {
    let anime: JikanAPIAnime
        
    var body: some View {
        VStack {
            if let imageURL = URL(string: anime.imageURL) {
                KFImage(imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}
