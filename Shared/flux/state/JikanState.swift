//
//  JikanState.swift
//  MyAnimeList
//
//  Created by HG on 2020/09/22.
//

import Foundation
import SwiftUIFlux
import JikanSwift

struct JikanState: FluxState, Codable {
    var topAiring: JikanAPITop<[JikanAPIAnime]>?
    var topUpcoming: JikanAPITop<[JikanAPIAnime]>?
    var topTv: JikanAPITop<[JikanAPIAnime]>?
    var topMovie: JikanAPITop<[JikanAPIAnime]>?
    var topOva: JikanAPITop<[JikanAPIAnime]>?
    var topSpecial: JikanAPITop<[JikanAPIAnime]>?
    var topBypopularity: JikanAPITop<[JikanAPIAnime]>?
    var topFavorite: JikanAPITop<[JikanAPIAnime]>?

    var animes: [Int: JikanAPIAnime] = [:]
}
