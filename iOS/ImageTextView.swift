//
//  ImageTextView.swift
//  MyAnimeList (iOS)
//
//  Created by HG on 2020/12/12.
//

import SwiftUI
import JikanSwift
import CrunchyrollSwift

struct ImageTextView<D: Codable, IT: ImageType, SheetContent: View>: View {
    let data: D
    let imageType: IT
    var title: String? {
        if let anime = data as? JikanAPIAnime {
            return anime.title
        }
        if let episode = data as? CRAPIMedia {
            return episode.name
        }
        return nil
    }
    var imageURL: String? {
        if let anime = data as? JikanAPIAnime {
            return anime.imageURL
        }
        if let episode = data as? CRAPIMedia {
            return episode.screenshotImage?.fwide_url
        }
        return nil
    }
    
    var action: () -> Void
    var sheetContent: SheetContent? = nil
    init(data: D, imageType: IT, action: @escaping () -> Void, @ViewBuilder sheetContent: () -> SheetContent) {
        self.data = data
        self.imageType = imageType
        self.action = action
        self.sheetContent = sheetContent()
    }
    
    @State private var isShowingDetailView = false
    @State private var modalDisplayed = false
    
    var body: some View {
        VStack {
            if let anime = data as? JikanAPIAnime {
                NavigationLink(destination: AnimeDetailView(anime: anime).environmentObject(store), isActive: $isShowingDetailView) {
                    EmptyView()
                }
                Button(action: {
                    self.isShowingDetailView = true
                    action()
                }) {
                    ImageTextItem(title: anime.title, imageURL: anime.imageURL)
                        .frame(width: imageType.width, height: imageType.height + 62)
                }
                .buttonStyle(PlainButtonStyle())
            }
            if let episode = data as? CRAPIMedia {
                Button(action: {
                    self.modalDisplayed = true
                    action()
                }, label: {
                    if let episodeNumber = episode.episodeNumber,
                       let name = episode.name,
                       let iamgeURL = episode.screenshotImage?.fwide_url {
                        ImageTextItem(title: "\(episodeNumber) \(name)", imageURL: iamgeURL)
                            .frame(width: imageType.width, height: imageType.height + 62)
                    }
                })
                .fullScreenCover(isPresented: $modalDisplayed) {
                    self.sheetContent
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
