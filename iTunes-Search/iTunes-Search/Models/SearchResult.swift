//
//  SearchResult.swift
//  iTunes-Search
//
//  Created by Alexander Supe on 1/14/20.
//  Copyright © 2020 Alexander Supe. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var title: String
    var creator: String
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    var results: [SearchResult]
}
