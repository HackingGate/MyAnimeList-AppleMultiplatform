//
//  NavigationViewIOS.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/15.
//

import SwiftUI

struct NavigationViewIOS<Content: View>: View {
    let viewBuilder: () -> Content
    let title: String
    var body: some View {
        #if os(iOS)
        NavigationView {
            viewBuilder()
                .navigationBarTitle(title)
        }
        #elseif os(macOS)
        StackNavigationView {
            viewBuilder()
        }
        #else
        viewBuilder()
        #endif
    }
}

struct NavigationViewIOS_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewIOS(viewBuilder: {
            Text("In a NavigationView when iOS")
        }, title: "Title")
    }
}
