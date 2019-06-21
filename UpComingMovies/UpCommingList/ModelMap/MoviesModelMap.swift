//
//  MoviesModelMap.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import Foundation
import ObjectMapper

/// Mapping Object
public class MoviesModelMap: Mappable {
  var voteCount: Int = 0
  var idM: Int = 0
  var video: Bool = false
  var voteAverage: Double = 0.0
  var title: String = ""
  var popularity: Double = 0.0
  var posterPath: String?
  var originalLanguage: String?
  var originalTitle: String?
  var genreIds: [Int] = []
  var backdropPath: String?
  var adult: Bool = false 
  var overview: String? 
  var releaseDate: String?
  
  required public init?(map: Map) {
  }
  
  public func mapping(map: Map) {
    voteCount <- map["vote_count"]
    idM <- map["id"]
    video <- map["video"]
    voteAverage <- map["voteAverage"]
    title <- map["title"]
    popularity <- map["popularity"]
    posterPath <- map["poster_path"]
    originalLanguage <- map["original_language"]
    originalTitle <- map["original_title"]
    genreIds <- map["genre_ids"]
    backdropPath <- map["backdrop_path"]
    adult <- map["adult"]
    overview <- map["overview"]
    releaseDate <- map["release_date"]
    
  }
}
