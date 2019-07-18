//
//  StatusModelCodable.swift
//  UpComingMovies
//
//  Created by FMMobile on 02/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation

///StatusModelCodable
public class StatusErrorModelCodable: Decodable {
  
  var statusCode: Int?
  var statusMessage: String?
  var success: Bool?
  
  private enum CodingKeys: String, CodingKey {
    case statusCode = "status_code"
    case statusMessage = "status_message"
    case success
  }
}
