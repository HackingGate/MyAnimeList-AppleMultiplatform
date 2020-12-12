//
//  AnimeCrosslineRow.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/11.
//

import SwiftUI
import SwiftUIFlux
import JikanSwift
import KingfisherSwiftUI

struct AnimeCrosslineRow: View {
    let title: String
    let animes: [JikanAPIAnime]
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            Text(title)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(animes) { anime in
                        AnimeDetailRowItem(anime: anime)
                    }
                }.padding(.leading)
            }
        }
    }
}

struct AnimeDetailRowItem: View {
    @State private var isShowingDetailView = false
    #if os(tvOS)
    // https://stackoverflow.com/a/59196076/4063462
    @State private var cardButtonFocusd = false
    #endif
    
    let anime: JikanAPIAnime
    var body: some View {
        #if os(iOS)
        // Sample code from https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
        // EmptyView() is not really empty on tvOS 14.2
        VStack {
            NavigationLink(destination: AnimeDetailView(anime: anime).environmentObject(store), isActive: $isShowingDetailView) {
                EmptyView()
            }
            Button(action: {
                displayAction()
            }) {
                AnimeDetailItem(title: anime.title, imageURL: anime.imageURL)
                    .frame(width: 100.0, height: 212.0)
            }
            .buttonStyle(PlainButtonStyle())
        }
        #else
        VStack {
            Button(action: {
                displayAction()
            }) {
                AnimeDetailItem(isFocusedBinding: $cardButtonFocusd,
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
        #endif
    }
}

extension AnimeDetailRowItem {
    func displayAction() {
        self.isShowingDetailView = true
        store.dispatch(action: JikanActions.Anime(id: anime.id,
                                                  request: .all,
                                                  params: nil))
        store.dispatch(action: MALSyncActions.MALAnime(id: anime.id,
                                                       params: nil))
    }
}

struct AnimeCrosslineRow_Previews: PreviewProvider {
    static var previews: some View {
        AnimeCrosslineRow(
            title: "Title",
            animes: []
        )
    }
}
