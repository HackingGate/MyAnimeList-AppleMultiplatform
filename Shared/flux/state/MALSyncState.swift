//
//  MALSyncState.swift
//  MyAnimeList
//
//  Created by HG on 2020/12/06.
//

import Foundation
import SwiftUIFlux
import MALSyncSwift

struct MALSyncState: FluxState, Codable {
    var malIDSites: [Int: MALSyncAPIMALSites] = [:]
}
