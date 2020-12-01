//
//  CRAnime.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/11.
//

import SwiftUI

struct CRAnime: Codable, Identifiable {
    let id: Int
    let title: String
    let seriesId: Int
    let collectionId: Int
}
