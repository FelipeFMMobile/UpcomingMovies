//
//  UpCommingCoordinator.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 11/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//
//  SwiftUI view's cover a tentative to give a first look on SwiftUI, also, keeping MVVM and Coordinator patterns
//  Some code arragement's still needed
//

import UIKit

protocol UpCommingCoordinatorHostingUIProtocol: AppCoordinator {
}

@available(iOS 15.0, *)
final class UpCommingCoordinatorHostingUI: UpCommingCoordinatorHostingUIProtocol {
    var navigation: UINavigationController!
    var view: UIViewController?
    
    required init(nav: UINavigationController) {
        navigation = nav
    }
    
    func instantiateView() -> UIViewController? {
        self.view = HostingUIController(uiView: getListMoviesUI())
        return view
    }
    
    func getListMoviesUI() -> ListMoviesUI {
        let view = ListMoviesUI()
        return view
    }
}
