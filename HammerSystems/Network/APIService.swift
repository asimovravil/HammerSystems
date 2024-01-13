//
//  APIService.swift
//  HammerSystems
//
//  Created by Ravil on 13.01.2024.
//

import Foundation

class APIService {
    let apiKey = "f70c01b294cc4c4d96f61c9593bd3e81"
    let baseURL = "https://api.spoonacular.com/food/search/"

    func fetchSearchResults(completion: @escaping (SearchResult?, Error?) -> Void) {
        let urlString = "\(baseURL)?apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Неверный URL"]))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Нет данных"]))
                return
            }
            do {
                let searchResults = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResults, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
