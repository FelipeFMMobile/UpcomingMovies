//
//  UpcomingProtocol.swift
//  UpComingMovies
//
//  Created by FMMobile on 04/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//
//  SOLID: Interface Segregation
//

import Foundation
import UpcomingMoviesApi

protocol UpComingTableViewsDataSetProtocol {
  associatedtype ValueModel
  func numberOfSections() -> Int
  func numRowsSection(section: Int) -> Int
  func valueForCellPosition(indexPath: IndexPath) -> ValueModel?
}

protocol UpComingSwiftUIDataSetProtocol {
  func genreForMovie(movie: MoviesModelCodable) -> GenreModelCodable?
  func instantiateDetailSegue(movie: MoviesModelCodable, _ completion: ((Result<Bool, ApiError>) -> Void)?)
}
