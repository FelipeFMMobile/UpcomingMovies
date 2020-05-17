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
    var view: UpComingListTableViewController! { get set }
    init()
    func gotoDetail(detailMovie: MoviesDetailModelCodable)
}

class UpCommingCoordinator: UpCommingCoordinatorProtocol {
    
    var view: UpComingListTableViewController!
    
    required init() {
        view = instantiateList()
    }
    
    private func instantiateList() -> UpComingListTableViewController {
        return AppStoryboard.instantiate(.list)
    }
    
    private func instantiateDetail(_ detailMovie: MoviesDetailModelCodable) -> DetailUpComingListTableViewController {
        let detailController: DetailUpComingListTableViewController = AppStoryboard.instantiate(.list)
        detailController.viewModel = DetailUpCommingListViewModel(movie: detailMovie)
        return detailController
    }
    
    // MARK: Navigation
    
    func gotoDetail(detailMovie: MoviesDetailModelCodable) {
        let detailController = instantiateDetail(detailMovie)
        DispatchQueue.main.async {
            self.view.navigationController?.pushViewController(detailController, animated: true)
        }
    }
}
