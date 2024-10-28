//
//  CategoryModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 23/10/24.
//

import Foundation

// MARK: - Welcome
struct FoodCategoryModel: Codable {
    let category: CategoryModel
    let items: [FeaturedRestaurant]
}

// MARK: - Category
struct CategoryModel: Codable {
    let name, description, image: String
}


