//
//  Category.swift
//  Fetch Rewards Code Challenge Alex C
//
//  Created by Alex Constancio on 9/28/21.
//

struct Category: Codable {
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}

struct Entry: Codable {
    let categories: [Category]
}
