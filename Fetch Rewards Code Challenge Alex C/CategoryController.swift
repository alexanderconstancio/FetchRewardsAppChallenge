//
//  CategoryController.swift
//  Fetch Rewards Code Challenge Alex C
//
//  Created by Alex Constancio on 9/28/21.
//

import UIKit

enum NetworkingError: Error {
    case troubleDecoding
    case badURL
    case conditionalError
}

class CategoryController {
    
    static var shared = CategoryController()
    
    var categories: [Category] = []
    
    func fetchCategoryJSON(completion: @escaping (Result<Bool, NetworkingError>) -> Void) {
        if let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") {
           URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let parsedJSON = try jsonDecoder.decode(Entry.self, from: data)
                    for category in parsedJSON.categories {
                        self.categories.append(category)
                    }
                } catch {
                    return completion(.failure(.troubleDecoding))
                }
            }
               
               return completion(.success(true))
           }.resume()
        }
    }
}
