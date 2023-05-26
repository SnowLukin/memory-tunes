//
//  AppReducer.swift
//  memory-tunes
//
//  Created by Snow Lukin on 25.05.2023.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    AppState(
        routingState: routingReducer(action: action, state: state?.routingState),
        menuState: menuReducer(action: action, state: state?.menuState),
        categoriesState: categoriesReducer(action: action, state: state?.categoriesState),
        gameState: gameReducer(action: action, state: state?.gameState)
    )
}
