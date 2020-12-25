//
//  ViewModifyExtension.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/23.
//

import SwiftUI

extension View {
    // https://blog.overdesigned.net/posts/2020-09-23-swiftui-availability/
    func modify<T: View>(@ViewBuilder _ modifier: (Self) -> T) -> some View {
        return modifier(self)
    }
}
