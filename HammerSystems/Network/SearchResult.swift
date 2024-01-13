//
//  SearchResult.swift
//  HammerSystems
//
//  Created by Ravil on 13.01.2024.
//

import Foundation

struct SearchResult: Codable {
    let recipes: [Recipe]
    let products: [Product]
    let menuItems: [MenuItem]
}

struct Recipe: Codable {
    let id: Int
    let name: String
    let image: String
    let link: String
}

struct Product: Codable {
    let id: Int
    let name: String
    let image: String
    let link: String
}

struct MenuItem: Codable {
    let id: Int
    let name: String
    let image: String
    let link: String
}
