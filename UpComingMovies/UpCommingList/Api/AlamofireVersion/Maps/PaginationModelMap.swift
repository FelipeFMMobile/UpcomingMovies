//
//  PaginationModelMap.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import Foundation
import ObjectMapper

/// Pagination Mapping Object
public class PaginationModelMap <T: Mappable>: StatusModelMap {
    var results: [T]?
    var page: Int = 0
    var totalResults: Int = 0
    var dates: [String: String]?
    var totalPages: Int = 0
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        results <- map["results"]
        page <- map["page"]
        totalResults <- map["total_results"]
        dates <- map["dates"]
        totalPages <- map["total_pages"]
    }
}
