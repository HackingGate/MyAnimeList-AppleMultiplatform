//
//  JikanCRActions.swift
//  MyAnimeList
//
//  Created by HG on 2020/09/22.
//

import Foundation
import SwiftUIFlux

struct JikanCRActions {
    struct SetMalIdSeriesId: Action {
        let malId: Int
        let seriesId: Int
    }
}
