//
//  MockPagination.swift
//  UpComingMoviesTests
//
//  Created by FMMobile on 02/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation
@testable import UpComingMovies

class MockPaginationModelCodable: PaginationModelCodable<MoviesModelCodable> {
  required init(from decoder: Decoder) throws {
    try super.init(from: decoder)
    self.page = 0 
    self.page = 0 
  }
}
