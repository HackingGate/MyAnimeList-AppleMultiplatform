//
//  AnimeCrosslineRow.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/11.
//

import SwiftUI
import SwiftUIFlux
import JikanSwift

struct AnimeCrosslineRow: View {
    let title: String
    let animes: [JikanAPIAnime]
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 32) {
                    ForEach(self.animes) { anime in
                        AnimeDetailRowItem(anime: anime)
                    }
                }.padding(.leading)
            }
        }
    }
}

struct AnimeDetailRowItem: View {
    @State private var isShowingDetailView = false

    let anime: JikanAPIAnime
    var body: some View {
        #if os(iOS)
        // Sample code from https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
        // EmptyView() is not really empty on tvOS 14.2
        VStack {
            NavigationLink(destination: AnimeDetailView(anime: anime).environmentObject(store), isActive: $isShowingDetailView) {
                EmptyView()
            }
            Button(anime.title) {
                displayAction()
            }
        }
        .frame(width: 80.0, height: 320.0, alignment: .center)
        #else
        Button(action: {
            displayAction()
        }, label: {
            Text(anime.title)
        })
        .sheet(isPresented: $isShowingDetailView) {
            AnimeDetailView(anime: anime).environmentObject(store)
        }
        #endif
    }

    func displayAction() {
        self.isShowingDetailView = true
        store.dispatch(action: JikanActions.Anime(id: anime.id,
                                                  request: .all,
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
