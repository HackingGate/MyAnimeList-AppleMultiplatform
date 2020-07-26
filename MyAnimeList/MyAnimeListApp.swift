//
//  MyAnimeListApp.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/09.
//

import SwiftUI
import SwiftUIFlux

@main
struct MyAnimeListApp: App {
    var body: some Scene {
        WindowGroup {
            MyTabView()
        }
    }
}

let store = Store<AppState>(reducer: appStateReducer,
                            middleware: [],
                            state: AppState())
