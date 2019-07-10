//
//  UpComingListViewModel.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2019 FMMobile. All rights reserved.
//
//  SOLID: Single Responsibility Principle, Interface Segregation
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol UpComingListViewModelRXProtocol {
  var moviesSubject: PublishSubject<[MoviesModelCodable]> { get set }
}

class UpComingListViewModelRX: UpComingListViewModel, UpComingListViewModelRXProtocol {
  var moviesSubject = PublishSubject<[MoviesModelCodable]>()
  
  override func getUpCommingMovies(complete: @escaping () -> Void) {
    super.getUpCommingMovies {
      self.moviesSubject.onNext(self.movies)
      complete()
    }
  }
}
