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
    let title: String
    let imageURL: String

    var body: some View {
        GeometryReader { geometry in
            VStack {
                if let imageURL = URL(string: imageURL) {
                    KFImage(imageURL)
                        .resizable()
                        .clipped()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.width * 1.5)
                        .cornerRadius(8)
                    Text(title)
                        .font(.caption)
                        .frame(width: geometry.size.width, alignment: .leading)
                    Spacer()
                } else {
                    Text(title)
                        .font(.caption)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                }
            }
        }
    }
}

struct AnimeDetailItem_Previews: PreviewProvider {
    static var previews: some View {
        AnimeDetailItem(title: "Kimi no Na wa.", imageURL: "https://cdn.myanimelist.net/images/anime/5/87048.jpg?s=2bca128fcb9dfd6d0908f3d9986576c6")
    }
}
