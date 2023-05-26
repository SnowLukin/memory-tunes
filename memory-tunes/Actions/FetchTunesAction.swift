//
//  FetchTunesAction.swift
//  memory-tunes
//
//  Created by Snow Lukin on 26.05.2023.
//

import ReSwift

func fetchTunes(state: AppState, store: Store<AppState>) -> FetchTunesAction {
    iTunesAPI.searchFor(category: state.categoriesState.currentCategorySelected.rawValue) { imageUrls in
        store.dispatch(SetCardsAction(cardImageUrls: imageUrls))
    }
    return FetchTunesAction()
}

struct FetchTunesAction: Action {
    
}
