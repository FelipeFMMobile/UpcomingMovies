//
//  BaseCoordinator.swift
//  UpComingMovies
//
//  Created by FelipeMenezes on 20/05/20.
//  Copyright © 2020 FMMobile. All rights reserved.
//

import Foundation

protocol UIViewCoordinator where Self: UIViewController {
    associatedtype T: AppCoordinator
    var coordinator: T? { get set }
}

enum TransitionType {
    case push
    case modal(UIViewController)
    case none
}

    protocol AppCoordinator {
        associatedtype T: UIViewCoordinator
        var view: T? { get set }
        var navigation: UINavigationController! { get set }
        init(nav: UINavigationController)
        func start(_ transition: TransitionType) -> T?
        func instantiateView() -> T?
    }

    extension AppCoordinator {
        func start(_ transition: TransitionType) -> T? {
            guard let view = instantiateView() else { return nil }
            view.coordinator = self as? Self.T.T
            
            switch transition {
            case .push:
                self.navigation.pushViewController(view, animated: true)
            case .modal(let parentController):
                self.navigation.viewControllers = [view]
                parentController.present(self.navigation, animated: true, completion: nil)
            case .none:
                self.navigation.viewControllers = [view]
            }
            return view
        }
    }
