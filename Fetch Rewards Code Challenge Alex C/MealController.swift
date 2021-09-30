//
//  MealController.swift
//  Fetch Rewards Code Challenge Alex C
//
//  Created by Alex Constancio on 9/28/21.
//

import UIKit

class MealController {
    
    var strCategory: String? {
        didSet {}
    }
    
    static var shared = MealController()
    
    var meals: [Meal] = []
    
    func fetchMealJSON(completion: @escaping (Result<Bool, NetworkingError>) -> Void) {
        guard let strCategory = strCategory else {
            return
        }
        
        meals.removeAll()

        if let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(strCategory)") {
           URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let parsedJSON = try jsonDecoder.decode(MealEntry.self, from: data)
                    for meal in parsedJSON.meals {
                        self.meals.append(meal)
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
