//
//  RoutingReducer.swift
//  memory-tunes
//
//  Created by Snow Lukin on 25.05.2023.
//

import ReSwift

func routingReducer(action: Action, state: RoutingState?) -> RoutingState {
    var state = state ?? RoutingState()
    
    switch action {
    case let routingAction as RoutingAction:
        state.navigationState = routingAction.destination
    default: break
    }
    
    return state
}
