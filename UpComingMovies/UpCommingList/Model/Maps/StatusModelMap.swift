//
//  StatusModelMap.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import Foundation
import ObjectMapper

/// Status Mapping Object
public class StatusModelMap: Mappable {
    var statusCode: Int = 0
    var statusMessage: String?
    var success: Bool = false
    
    required public init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        statusCode <- map["status_code"]
        statusMessage <- map["status_message"]
        success <- map["success"]
    }
}
