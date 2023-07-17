//
//  UpcomingProtocol.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 04/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//
//  SOLID: Interface Segregation
//

import SwiftApiSDK
import UIKit

protocol UpComingTableViewDataSetProtocol {
  associatedtype ValueModel
  func numberOfSections() -> Int
  func numRowsSection(section: Int) -> Int
  func valueForCellPosition(indexPath: IndexPath) -> ValueModel?
}

protocol UpComingSwiftUIDataSetProtocol {
  func genreForMovie(movie: MoviesModelCodable) -> GenreModelCodable?
}
