//
//  MyAnimeListApp.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/09.
//

import SwiftUI
import SwiftUIFlux
import AVFoundation

@main
struct MyAnimeListApp: App {
    var body: some Scene {
        WindowGroup {
            StoreProvider(store: store) {
                MyTabView()
            }.onAppear() {
                // AVAudioSession not avaliable on macOS
                #if canImport(UIKit)
                // The app's AVAudioSession must be a PiP-appropriate audio category, such as AVAudioSessionCategoryPlayback.
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
                } catch {
                    print("Setting category to AVAudioSessionCategoryPlayback failed.")
                }
                #endif
            }
        }
    }
}

let store = Store<AppState>(reducer: appStateReducer,
                            middleware: [],
                            state: AppState())
