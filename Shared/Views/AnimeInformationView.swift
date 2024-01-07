//
//  AnimeInformationView.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/17.
//

import SwiftUI
import JikanSwift
import KingfisherSwiftUI

struct AnimeInformationView: View {
    let animeDetail: JikanAPIAnime

    @State private var modalDisplayed = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            #if os(tvOS)
            Text(animeDetail.title)
                .font(.title)
            #endif
            if let titleJapanese = animeDetail.titleJapanese {
                Text(titleJapanese)
                    .font(.title)
            }
            if let synopsis = animeDetail.synopsis {
                Button(action: {
                    modalDisplayed = true
                }) {
                    Text(synopsis)
                        .font(.body)
                        .lineLimit(3)
                }
                .sheet(isPresented: $modalDisplayed, content: {
                    TextSheetView(title: animeDetail.title, synopsis: synopsis)
                })
            }
        }
        Spacer()
        if let imageURL = URL(string: animeDetail.images.webp.imageURL) {
            KFImage(imageURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: CommonImageSize.posterImage.width, height: CommonImageSize.posterImage.height)
        }
    }
}
