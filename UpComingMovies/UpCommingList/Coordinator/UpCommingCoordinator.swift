//
//  UpCommingCoordinator.swift
//  UpComingMovies
//
//  Created by FMMobile on 11/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation

protocol UpCommingCoordinatorProtocol: AppCoordinator {
    func instantiateDetail(_ detailMovie: MoviesDetailModelCodable) -> DetailUpComingListTableViewController
    func gotoDetail(detailMovie: MoviesDetailModelCodable)
}

class UpCommingCoordinator: UpCommingCoordinatorProtocol {
    
    typealias ListView = UpComingListTableViewController
    typealias DetailView = DetailUpComingListTableViewController
    
    var navigation: UINavigationController!
    var view: ListView?
    
    required init(nav: UINavigationController) {
        navigation = nav
    }
    
    func instantiateView() -> ListView? {
        return ListView.instantiate(.list)
    }
    
    internal func instantiateDetail(_ detailMovie: MoviesDetailModelCodable) -> DetailView {
        let detailController: DetailView = DetailView.instantiate(.list)
        detailController.viewModel = DetailUpCommingListViewModel(movie: detailMovie)
        return detailController
    }
    
    // MARK: Navigation
    
    func gotoDetail(detailMovie: MoviesDetailModelCodable) {
        DispatchQueue.main.async {
            let detailController = self.instantiateDetail(detailMovie)
            self.navigation.pushViewController(detailController, animated: true)
        }
    }
}

extension UpCommingCoordinator: AppCoordinatorDelegate {
    func gotoFlow<T>(_ name: String, model: T) where T: Decodable {
        guard let model = model as? MoviesDetailModelCodable else { return }
        gotoDetail(detailMovie: model)
    }
}
