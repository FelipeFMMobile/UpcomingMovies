//
//  MoviesDetailModelMap.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import Foundation
import ObjectMapper

/// Mapping Object
public class MoviesDetailModelMap: Mappable {
    var adult: Bool = false 
    var backDropPath: String = ""
    var belongsToCollection: String?
    var budget: Int = 0
    var genres: [GenreModelMap]?
    var homepage: String?
    var idM: Int = 0
    var imdbId: String = ""
    var originalLanguage: String = "" 
    var originalTitle: String = ""
    var overview: String = ""
    var popularity: Double = 0.0 
    var posterPath: String = "" 
    var productionCompanies: [[String: Any]]?
    var releaseDate: String?
    var revenue: Int = 0
    var runtime: Int = 0
    var spokenLanguages: [[String: Any]]?
    var status: String = ""
    var tagline: String = ""
    var title: String = ""
    var video: Bool = false
    var voteAverage: Int = 0
    var voteCount: Int = 0
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        adult <- map["adult"]
        backDropPath <- map["backdrop_path"]
        budget <- map["budget"]
        belongsToCollection <- map["belongs_to_collection"]
        genres <- map["genres"]
        idM <- map["id"]
        imdbId <- map["imdb_id"]
        originalLanguage <- map["original_language"]
        originalTitle <- map["original_title"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        posterPath <- map["poster_path"]
        productionCompanies <- map["production_companies"]
        releaseDate <- map["release_date"]
        revenue <- map["revenue"]
        releaseDate <- map["release_date"]
        runtime <- map["runtime"]
        spokenLanguages <- map["spoken_languages"]
        status <- map["status"]
        tagline <- map["tagline"]
        title <- map["title"]
        video <- map["video"]
        voteAverage <- map["vote_average"]
        voteCount <- map["vote_count"]
        
    }
}
