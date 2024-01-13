//
//  SearchResult.swift
//  HammerSystems
//
//  Created by Ravil on 13.01.2024.
//

import Foundation

struct SearchResult: Codable {
    let searchResults: [CategoryResult]
}

struct CategoryResult: Codable {
    let name: String
    let results: [CategoryItem]
}

struct CategoryItem: Codable {
    let id: Int
    let name: String
    let image: String
    let link: String
}
