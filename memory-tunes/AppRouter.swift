//
//  AppRouter.swift
//  memory-tunes
//
//  Created by Snow Lukin on 25.05.2023.
//

import ReSwift

enum RoutingDestination {
    case menu
    case categories
    case game
}

final class AppRouter {
    
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        store.subscribe(self) { subscription in
            subscription.select { state in
                state.routingState
            }
        }
    }
    
    fileprivate func pushViewController(route: RoutingDestination, animated: Bool) {
        let viewController = instantiateViewController(route: route)
        let newViewControllerType = type(of: viewController)
        if let currentVc = navigationController.topViewController {
            let currentViewControllerType = type(of: currentVc)
            if currentViewControllerType == newViewControllerType {
                return
            }
        }

        navigationController.pushViewController(viewController, animated: animated)
    }
    
    private func instantiateViewController(route: RoutingDestination) -> UIViewController {
        switch route {
        case .menu:
            return MenuViewController()
        case .categories:
            return CategoriesTableViewController()
        case .game:
            return GameViewController()
        }
    }
}

extension AppRouter: StoreSubscriber {
    func newState(state: RoutingState) {
        let shouldAnimate = navigationController.topViewController != nil
        pushViewController(route: state.navigationState, animated: shouldAnimate)
    }
}
