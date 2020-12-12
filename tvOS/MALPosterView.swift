//
//  MALPosterView.swift
//  MyAnimeList (tvOS)
//
//  Created by HG on 2020/12/12.
//

import SwiftUI
import JikanSwift

struct MALPosterView: View {
    @State var isShowingDetailView = false
    // https://stackoverflow.com/a/59196076/4063462
    @State private var cardButtonFocusd = false
    
    let anime: JikanAPIAnime
    var body: some View {
        VStack {
            Button(action: {
                displayAction()
            }) {
                MALPosterItem(isFocusedBinding: $cardButtonFocusd,
                                imageURL: anime.imageURL)
                    .frame(width: 200.0, height: 300.0)
            }
            .buttonStyle(CardButtonStyle())
            .padding(.all, 25)
            .sheet(isPresented: $isShowingDetailView) {
                AnimeDetailView(anime: anime).environmentObject(store)
            }
            Text(anime.title)
                .lineLimit(1)
                .frame(width: cardButtonFocusd ? 225.0 : 200.0, alignment: .leading)
                .padding(.top, cardButtonFocusd ? 0 : -25)
                .padding(.bottom, cardButtonFocusd ? 0 : 25)
            Spacer()
        }
    }
}
