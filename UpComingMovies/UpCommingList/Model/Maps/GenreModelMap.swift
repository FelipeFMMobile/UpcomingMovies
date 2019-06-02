//
//  GenreModelMap.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import Foundation
import ObjectMapper

/// Genre Mapping Object
public class GenreListModelMap: Mappable {
  var genres: [GenreModelMap]?
  
  required public init?(map: Map) {
  }
  
  public func mapping(map: Map) {
    genres <- map["genres"]
  }
  
  //we need to choice a better place for this 
  public func genresForMovie(movie: MoviesModelMap) -> [GenreModelMap]? {
    return genres?.filter { 
        return movie.genreIds.contains($0.idGenre)
    }
  }
}

public class GenreModelMap: Mappable {
  var idGenre: Int = 0
  var name: String?
  
  required public init?(map: Map) {
  }
  
  public  func mapping(map: Map) {
    idGenre <- map["id"]
    name <- map["name"]
  }
}
