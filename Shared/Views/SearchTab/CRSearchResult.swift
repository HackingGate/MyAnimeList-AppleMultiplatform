//
//  CRSearchResult.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/22.
//

import SwiftUI
import CrunchyrollSwift
import KingfisherSwiftUI

struct CRSearchResult: View {
    
    let result: [CRAPISeries]
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(result) { series in
                HStack(alignment: .center, spacing: 20) {
                    if let imageURL = URL(string: series.portraitImage.large_url) {
                        KFImage(imageURL)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: Common().posterImage.width, height: Common().posterImage.height)
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text(series.name)
                            .font(.headline)
                            .lineLimit(2)
                        Text(series.description)
                            .font(.subheadline)
                            .lineLimit(3)
                    }
                }
                .padding()
                Divider()
            }
        }
    }
}
