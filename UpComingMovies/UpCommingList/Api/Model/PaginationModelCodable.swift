//
//  PaginationModelCodable.swift
//  UpComingMovies
//
//  Created by FMMobile on 02/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation

/// PaginationModelCodable
public class PaginationModelCodable<T>: StatusErrorModelCodable where T: Decodable {
    public class DatesCodable: Decodable {
        var maximum: String
        var minimum: String
    }

    var results: [T]?
    var page: Int
    var totalResults: Int
    var dates: DatesCodable?
    var totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
    
    public required init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        do { self.results = try map.decode([T].self, forKey: .results) } catch let error { print(error) }
        self.page = try map.decode(Int.self, forKey: .page)
        self.totalResults = try map.decode(Int.self, forKey: .totalResults)
        self.dates = try? map.decode(DatesCodable.self, forKey: .dates)
        self.totalPages = try map.decode(Int.self, forKey: .totalPages)
        try super.init(from: decoder)
    }
}
