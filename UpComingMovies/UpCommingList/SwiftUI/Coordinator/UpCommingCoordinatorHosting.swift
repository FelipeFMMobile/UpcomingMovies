//
//  UpCommingCoordinator.swift
//  UpComingMovies
//
//  Created by FMMobile on 11/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//
//  SwiftUI view's cover a tentative to give a first look on SwiftUI, also, keeping MVVM and Coordinator patterns
//  Some code arragement's still needed
//

protocol UpCommingCoordinatorHostingProtocol: AppCoordinator {
}

@available(iOS 14.0, *)
final class UpCommingCoordinatorHosting: UpCommingCoordinatorHostingProtocol {
    var navigation: UINavigationController!
    var view: UIViewController?
    
    required init(nav: UINavigationController) {
        navigation = nav
    }
    
    func instantiateView() -> UIViewController? {
        self.view = HostingController(uiView: getListMoviesUI())
        return view
    }
    
    func getListMoviesUI() -> ListMoviesUI {
        let view = ListMoviesUI()
        return view
    }
}
