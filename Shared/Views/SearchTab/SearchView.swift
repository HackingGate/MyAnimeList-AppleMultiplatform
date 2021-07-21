//
//  SearchView.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/09.
//

import SwiftUI
import SwiftUIFlux
import CrunchyrollSwift

struct SearchView: View {
    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject private var store: Store<AppState>

    @State var searchText = ""

    private var result: [CRAPISeries]? {
        store.state.crState.queries[searchText]
    }

    var body: some View {
        NavigationViewIOS(viewBuilder: {
            ZStack {
                if searchText.count > 0 {
                    if let result = result {
                        ScrollView(.vertical) {
                            CRSearchResult(result: result)
                        }
                    } else {
                        #if os(macOS)
                        Text("Hit return to search!")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        #endif
                    }
                }
            }
            #if os(macOS)
            .background(colorScheme == .light ? Color.white : Color(red: 45 / 255, green: 45 / 255, blue: 45 / 255))
            #endif
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                if let session = store.state.crState.session, searchText.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                    store.dispatch(action: CRActions.Autocomplete(sessionId: session.id, q: searchText))
                }
            }
        }, title: "Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
