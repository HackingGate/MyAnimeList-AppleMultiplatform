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
    let imageURL: String
        
    var body: some View {
        if let imageURL = URL(string: imageURL) {
            KFImage(imageURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}

struct AnimeDetailItem_Previews: PreviewProvider {
    static var previews: some View {
        AnimeDetailItem(imageURL: "https://cdn.myanimelist.net/images/anime/5/87048.jpg?s=2bca128fcb9dfd6d0908f3d9986576c6")
    }
}
