//
//  AppCoordinator.swift
//  UpComingMovies
//
//  Created by FelipeMenezes on 20/05/20.
//  Copyright © 2020 FMMobile. All rights reserved.
//

protocol ViewModelCoordinator {
    var coordinatorDelegate: AppCoordinatorDelegate? { get set }
}

protocol AppCoordinatorDelegate: AnyObject {
    func goToFlow(_ name: String)
    func goToFlow<T: Decodable>(_ name: String, model: T)
}

enum TransitionType {
    case push
    case modal(controller: UIViewController)
    case first
    case none
}

enum AppCoordinatorError: Error {
    case failedInstantiateViewController
    case faliedStartCoordinator
}

protocol AppCoordinator {
    associatedtype T: UIViewController
    var view: T? { get set }
    var navigation: UINavigationController! { get set }
    
    init(nav: UINavigationController)
    mutating func start(_ transition: TransitionType) throws -> T
    func instantiateView() -> T?
}

extension AppCoordinator {
    mutating func start(_ transition: TransitionType) throws -> T {
        guard let view = instantiateView() else { throw AppCoordinatorError.failedInstantiateViewController }

        switch transition {
        case .push:
            self.navigation.pushViewController(view, animated: true)
        case .modal(let parentController):
            self.navigation.viewControllers = [view]
            parentController.present(self.navigation, animated: true, completion: nil)
        case .first:
            self.navigation.viewControllers = [view]
        case .none:
            break
        }
        return view
    }
}
