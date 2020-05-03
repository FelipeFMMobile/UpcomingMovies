//
//  GenreResponseCodable.swift
//  UpcomingMoviesApiTests
//
//  Created by FMMobile on 19/05/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct GenreList: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let ids: Int
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case ids = "id"
        case name
    }
}
