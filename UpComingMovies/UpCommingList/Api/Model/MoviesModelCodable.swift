//
//  MoviesModelMap.swift
//  MoviesModelCodable
//
//  Created by FMMobile on 02/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation

/// MoviesModelCodable
final public class MoviesModelCodable: Decodable, Equatable {
    var voteCount: Int
    var idM: Int
    var video: Bool
    var voteAverage: Double
    var title: String
    var popularity: Double
    var posterPath: String?
    var originalLanguage: String?
    var originalTitle: String?
    var genreIds: [Int]
    var backdropPath: String?
    var adult: Bool
    var overview: String? 
    var releaseDate: String?
    
    private enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case idM = "id"
        case video = "video"
        case voteAverage = "vote_average"
        case title
        case popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult
        case overview
        case releaseDate = "release_date"
    }
    
    public func firstGenreName() -> String {
        // TODO: Parse genre name here
        return ""
    }
    
    public static func == (lhs: MoviesModelCodable, rhs: MoviesModelCodable) -> Bool {
        return lhs.idM == rhs.idM
    }
}
