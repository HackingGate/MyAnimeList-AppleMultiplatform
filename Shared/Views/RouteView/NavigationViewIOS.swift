//
//  NavigationViewIOS.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/15.
//

import SwiftUI

struct NavigationViewIOS<Content: View>: View {
    let viewBuilder: () -> Content
    var body: some View {
        #if os(iOS)
        NavigationView {
            viewBuilder()
                .navigationBarTitle("Home")
        }
        #else
        viewBuilder()
        #endif
    }
}

struct NavigationViewIOS_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewIOS {
            Text("In a NavigationView when iOS")
        }
    }
}
