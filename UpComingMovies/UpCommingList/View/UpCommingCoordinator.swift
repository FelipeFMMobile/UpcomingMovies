//
//  UpCommingCoordinator.swift
//  UpComingMovies
//
//  Created by FMMobile on 11/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation
import SVProgressHUD

protocol UpCommingCoordinatorProtocol {
  var parentController: UIViewController { get set }
  init(controller: UIViewController)
  func instantiateDetailSegue(detailMovie: MoviesDetailModelCodable) -> Bool
  
}

class UpCommingCoordinator: UpCommingCoordinatorProtocol {
  
  var parentController: UIViewController
  
  required init(controller: UIViewController) {
    self.parentController = controller
  }
  
  func instantiateDetailSegue(detailMovie: MoviesDetailModelCodable) -> Bool {
    if let detailController = self.parentController.storyboard?.instantiateViewController(
withIdentifier: DetailUpComingListTableViewController.DetailIdentifier)  
      as? DetailUpComingListTableViewController {
      detailController.viewModel = DetailUpCommingListViewModel(movie: detailMovie)
      DispatchQueue.main.async {
        self.parentController.navigationController?.pushViewController(detailController, animated: true)
      }
      return true
    }
    return false
  }
}
