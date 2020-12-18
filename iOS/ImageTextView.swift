//
//  ImageTextView.swift
//  MyAnimeList (iOS)
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
         useModal: Bool = false,
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
    
    var body: some View {
        VStack {
            if let title = title, let imageURL = imageURL {
                NavigationLink(destination: content, isActive: $isShowingDetailView) {
                    EmptyView()
                }
                Button(action: {
                    isShowingDetailView = true && !useModal
                    modalDisplayed = true && useModal
                    action()
                }) {
                    ImageTextItem(title: title, imageURL: imageURL)
                        .frame(width: imageType.width, height: imageType.height + 62)
                }
                .fullScreenCover(isPresented: $modalDisplayed) {
                    content
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
