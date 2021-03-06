//
//  ImageTextView.swift
//  MyAnimeList (tvOS)
//
//  Created by HG on 2020/12/12.
//

import SwiftUI
import JikanSwift
import CrunchyrollSwift

struct ImageTextView<D: Codable, Content: View>: View {
    let data: D
    let imageSize: CGSize
    let useModal: Bool
    var content: Content
    var action: () -> Void

    init(data: D,
         imageSize: CGSize,
         useModal: Bool = true,
         @ViewBuilder content: () -> Content,
         action: @escaping () -> Void
    ) {
        self.data = data
        self.imageSize = imageSize
        self.useModal = useModal
        self.content = content()
        self.action = action
        #if DEBUG
        print("Lazy Loading ImageTextView for \(data)")
        #endif
    }

    private var title: String? {
        if let anime = data as? JikanAPIAnime {
            return anime.title
        }
        if let episode = data as? CRAPIMedia {
            var title: String?
            if let episodeNumber = episode.episodeNumber {
                title = "\(episodeNumber): "
            }
            if let name = episode.name {
                title = "\((title ?? "") + name)"
            }
            return title
        }
        return nil
    }
    private var imageURL: String? {
        if let anime = data as? JikanAPIAnime {
            return anime.imageURL
        }
        if let episode = data as? CRAPIMedia {
            return episode.screenshotImage?.fwideUrl
        }
        return nil
    }

    @State private var isShowingDetailView = false
    @State private var modalDisplayed = false
    // https://stackoverflow.com/a/59196076/4063462
    @State private var cardButtonFocusd = false

    private func carButtonAnimation(isFocused: Bool) -> Animation {
        return Animation.easeOut(duration: isFocused ? 0.1 : 0.3)
    }

    var body: some View {
        VStack {
            if let title = title, let imageURL = imageURL {
                Button(action: {
                    self.isShowingDetailView = true
                    action()
                }) {
                    ImageItem(isFocusedBinding: $cardButtonFocusd,
                              imageURL: imageURL)
                        .frame(width: imageSize.width, height: imageSize.height)
                }
                .buttonStyle(CardButtonStyle())
                .padding(.horizontal, imageSize.width * 0.08)
                .padding(.vertical, imageSize.height * 0.08)
                .sheet(isPresented: $isShowingDetailView) {
                    content
                }
                Text(title)
                    .lineLimit(1)
                    .frame(width: imageSize.width + (cardButtonFocusd ? imageSize.width * 0.12 : 0), alignment: .leading)
                    .padding(.top, cardButtonFocusd ? 0 : -imageSize.height * 0.1)
                    .padding(.bottom, cardButtonFocusd ? 0 : imageSize.height * 0.1)
                    .animation(carButtonAnimation(isFocused: cardButtonFocusd))
                // TODO: sliding Text animation
                // https://stackoverflow.com/questions/63726455/swiftui-sliding-text-animation-and-positioning
                Spacer()
            }
        }
    }
}
