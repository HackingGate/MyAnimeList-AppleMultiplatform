//
//  CRWebParser.swift
//  MyAnimeList
//
//  Created by HG on 2020/08/16.
//

import Foundation
import Kanna

struct CRWebParser {
    static func seriesId(_ url: URL) -> Int? {
        if let doc = try? HTML(url: url, encoding: .utf8) {
            // Search for nodes by CSS
            for node in doc.css("div, class") {
                if node.className == "show-actions" {
                    if let groupId = node["group_id"] {
                        return Int(groupId)
                    }
                }
            }
        }
        return nil
    }
}
