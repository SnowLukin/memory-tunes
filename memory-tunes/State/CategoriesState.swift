//
//  CategoriesState.swift
//  memory-tunes
//
//  Created by Snow Lukin on 26.05.2023.
//

import ReSwift

enum Category: String {
    case pop = "Pop"
    case electronic = "Electronic"
    case rock = "Rock"
    case metal = "Metal"
}

struct CategoriesState {
    let categories: [Category]
    var currentCategorySelected: Category
    
    init(currentCategory: Category) {
        categories = [.pop, .electronic, .rock, .metal]
        currentCategorySelected = currentCategory
    }
}
