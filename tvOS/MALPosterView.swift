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
    var imageWidth: CGFloat = 200.0
    var imageHeight: CGFloat {
        imageWidth * 1.5
    }
    private let paddingWhenFocused: CGFloat = 25.0
    private func carButtonAnimation(isFocused: Bool) -> Animation {
        return Animation.easeOut(duration: isFocused ? 0.1 : 0.3)
    }
    
    var body: some View {
        VStack {
            Button(action: {
                displayAction()
            }) {
                MALPosterItem(isFocusedBinding: $cardButtonFocusd,
                                imageURL: anime.imageURL)
                    .frame(width: imageWidth, height: imageHeight)
            }
            .buttonStyle(CardButtonStyle())
            .padding(.all, paddingWhenFocused)
            .sheet(isPresented: $isShowingDetailView) {
                AnimeDetailView(anime: anime).environmentObject(store)
            }
            Text(anime.title)
                .lineLimit(1)
                .frame(width: imageWidth + (cardButtonFocusd ? paddingWhenFocused : 0), alignment: .leading)
                .padding(.top, cardButtonFocusd ? 0 : -paddingWhenFocused)
                .padding(.bottom, cardButtonFocusd ? 0 : paddingWhenFocused)
                .animation(carButtonAnimation(isFocused: cardButtonFocusd))
            // TODO: sliding Text animation
            // https://stackoverflow.com/questions/63726455/swiftui-sliding-text-animation-and-positioning
            Spacer()
        }
    }
}
