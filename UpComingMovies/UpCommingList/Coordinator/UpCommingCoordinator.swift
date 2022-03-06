//
//  UpCommingCoordinator.swift
//  UpComingMovies
//
//  Created by FMMobile on 11/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

protocol UpCommingCoordinatorProtocol: AppCoordinator {
    func instantiateDetail(_ detailMovie: MoviesDetailModelCodable) -> DetailUpComingListTableViewController
    func gotoDetail(detailMovie: MoviesDetailModelCodable)
    func gotToRXVersion()
}

class UpCommingCoordinator: UpCommingCoordinatorProtocol {
    
    typealias ListView = UpComingListTableViewController
    typealias DetailView = DetailUpComingListTableViewController
    typealias ListViewRX = UpComingListRXTableViewController
    
    var navigation: UINavigationController!
    var view: ListView?

    required init(nav: UINavigationController) {
        navigation = nav
    }
    
    func instantiateView() -> ListView? {
        return getListViewCode()
    }
    
    internal func getListViewCode() -> ListView? {
        let view: ListView =  ListView()
        view.viewModel.coordinatorDelegate = self
        return view
    }
    
    internal func getListViewRXStoryboard() -> ListViewRX? {
        let view: ListViewRX =  ListViewRX.instantiate(.list)
        view.viewModel.coordinatorDelegate = self
        return view
    }
    
    internal func instantiateDetail(_ detailMovie: MoviesDetailModelCodable) -> DetailView {
        let detailController: DetailView = DetailView.instantiate(.detail)
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
    
    func gotToRXVersion() {
        DispatchQueue.main.async {
            if let view = self.getListViewRXStoryboard() {
                self.navigation.pushViewController(view, animated: true)
            }
        }
    }
}

extension UpCommingCoordinator: AppCoordinatorDelegate {
    func goToFlow(_ name: String) {
        if name == "rx" { gotToRXVersion() }
    }

    func goToFlow<T>(_ name: String, model: T) where T : Decodable {
        guard let model = model as? MoviesDetailModelCodable else { return }
        gotoDetail(detailMovie: model)
    }
}
