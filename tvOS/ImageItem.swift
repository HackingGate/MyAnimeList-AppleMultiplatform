//
//  ImageTextItem.swift
//  MyAnimeList (tvOS)
//
//  Created by HG on 2020/12/09.
//

import SwiftUI
import JikanSwift
import KingfisherSwiftUI

struct ImageItem: View {
    @Environment(\.isFocused) private var isFocused
    var isFocusedBinding: Binding<Bool>?

    let imageURL: String

    var body: some View {
        ZStack {
            report()
            if let imageURL = URL(string: imageURL) {
                KFImage(imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }

    func report() -> some View {
        DispatchQueue.main.async {
            self.isFocusedBinding?.wrappedValue = self.isFocused
        }
        return EmptyView()
    }
}

struct AnimeDetailItem_Previews: PreviewProvider {
    static var previews: some View {
        ImageItem(imageURL: "https://cdn.myanimelist.net/images/anime/5/87048.jpg?s=2bca128fcb9dfd6d0908f3d9986576c6")
    }
}
