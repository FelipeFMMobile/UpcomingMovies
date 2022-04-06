//
//  GenreModelMap.swift
//  UpComingMovies
//
//  Created by FMMobile on 02/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

/// Genre Model Object
public class GenreListModelCodable: Decodable {
    var genres: [GenreModelCodable]?
    
    // we need to choice a better place for this
    public func genresForMovie(movie: MoviesModelCodable) -> [GenreModelCodable]? {
        return genres?.filter {
            return movie.genreIds.contains($0.idGenre)
        }
    }
}

public class GenreModelCodable: Decodable {
    var idGenre: Int
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case idGenre = "id"
        case name
    }
}
