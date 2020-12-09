//
//  AnimeDetailItem.swift
//  MyAnimeList (iOS)
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
                    .cornerRadius(8)
                    .frame(width: 80.0, height: 160.0)
                    .layoutPriority(-1)
                Text(anime.title)
                    .font(.system(size: 14))
                    .frame(width: 108, alignment: .leading)
                Spacer()
            } else {
                Text(anime.title)
                    .font(.system(size: 14))
            }
        }
    }
}
