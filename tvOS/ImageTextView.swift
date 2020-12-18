//
//  ImageTextView.swift
//  MyAnimeList (tvOS)
//
//  Created by HG on 2020/12/12.
//

import SwiftUI
import JikanSwift
import CrunchyrollSwift

struct ImageTextView<D: Codable, IT: ImageType, Content: View>: View {
    let data: D
    let imageType: IT
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
            return episode.screenshotImage?.fwide_url
        }
        return nil
    }
    
    var action: () -> Void
    var content: Content
    var useModal: Bool
    init(data: D,
         imageType: IT,
         useModal: Bool = true,
         @ViewBuilder content: () -> Content,
         action: @escaping () -> Void
    ) {
        self.data = data
        self.imageType = imageType
        self.useModal = useModal
        self.content = content()
        self.action = action
    }
    
    @State private var isShowingDetailView = false
    @State private var modalDisplayed = false
    // https://stackoverflow.com/a/59196076/4063462
    @State private var cardButtonFocusd = false
    
    private let paddingWhenFocused: CGFloat = 25.0
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
                        .frame(width: imageType.width, height: imageType.height)
                }
                .buttonStyle(CardButtonStyle())
                .padding(.all, paddingWhenFocused)
                .sheet(isPresented: $isShowingDetailView) {
                    content
                }
                Text(title)
                    .lineLimit(1)
                    .frame(width: imageType.width + (cardButtonFocusd ? paddingWhenFocused : 0), alignment: .leading)
                    .padding(.top, cardButtonFocusd ? 0 : -paddingWhenFocused)
                    .padding(.bottom, cardButtonFocusd ? 0 : paddingWhenFocused)
                    .animation(carButtonAnimation(isFocused: cardButtonFocusd))
                // TODO: sliding Text animation
                // https://stackoverflow.com/questions/63726455/swiftui-sliding-text-animation-and-positioning
                Spacer()
            }
        }
    }
}
