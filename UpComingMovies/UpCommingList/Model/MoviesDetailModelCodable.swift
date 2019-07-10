//
//  MoviesDetailModelCodable.swift
//  UpComingMovies
//
//  Created by FMMobile on 02/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation

/// MoviesDetailModelCodable
public class MoviesDetailModelCodable: Decodable {
  var adult: Bool
  var backDropPath: String
  var belongsToCollection: CollectionCodable?
  var budget: Int
  var genres: [GenreModelCodable]?
  var homepage: String?
  var idM: Int
  var imdbId: String
  var originalLanguage: String
  var originalTitle: String
  var overview: String
  var popularity: Double
  var posterPath: String
  var releaseDate: String?
  var revenue: Int
  var runtime: Int
  var status: String
  var tagline: String
  var title: String
  var video: Bool
  var voteAverage: Double
  var voteCount: Int
  
  private enum CodingKeys: String, CodingKey {
    case adult
    case backDropPath = "backdrop_path"
    case budget = "budget"
    case belongsToCollection = "belongs_to_collection"
    case genres = "genres"
    case idM = "id"
    case imdbId = "imdb_id"
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview = "overview"
    case popularity = "popularity"
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case revenue = "revenue"
    case runtime = "runtime"
    case status = "status"
    case tagline = "tagline"
    case title = "title"
    case video = "video"
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

public class CollectionCodable: Decodable {
  var idM: Int
  var name: String
  var posterPath: String?
  var backdroPath: String?
  
  private enum CodingKeys: String, CodingKey {
    case idM = "id"
    case name
    case posterPath = "poster_path"
    case backdroPath = "backdrop_path"
  }   
}
