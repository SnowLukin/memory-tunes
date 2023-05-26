//
//  RoutingState.swift
//  memory-tunes
//
//  Created by Snow Lukin on 25.05.2023.
//

import ReSwift

struct RoutingState {
    var navigationState: RoutingDestination
    
    init(navigationState: RoutingDestination = .menu) {
        self.navigationState = navigationState
    }
}
