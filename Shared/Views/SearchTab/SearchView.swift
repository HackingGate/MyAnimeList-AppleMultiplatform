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
    @EnvironmentObject private var store: Store<AppState>

    @State var searchText = ""

    private var result: [CRAPISeries] {
        store.state.crState.queries[searchText] ?? []
    }

    var body: some View {
        NavigationViewIOS(viewBuilder: {
            ScrollView(.vertical) {
                CRSearchResult(result: result)
            }
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
