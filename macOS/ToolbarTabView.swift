//
//  ToolbarTabView.swift
//  ToolbarTabView
//
//  Created by HG on 2021/07/18.
//

import SwiftUI

struct ToolbarTabView: View {
    @State private var selectedTab = 0
    @State private var searchText = ""

    var body: some View {
        ZStack {
            if selectedTab == 0 {
                HomeView()
            } else if selectedTab == 1 {
                // TODO: second tab
            }
            SearchView()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("", selection: $selectedTab) {
                    Text("Home").tag(0)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(minWidth: 80)
            }
        }
        .frame(minWidth: 800, minHeight: 500)
    }
}

struct ToolbarTabView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarTabView()
    }
}
