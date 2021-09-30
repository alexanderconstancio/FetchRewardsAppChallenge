//
//  DetailsController.swift
//  Fetch Rewards Code Challenge Alex C
//
//  Created by Alex Constancio on 9/28/21.
//

import Foundation

class DetailController {
    
    var mealID: String? {
        didSet {}
    }
    
    static var shared = DetailController()
    
    var details: Details?
    
    func fetchCategoryJSON(completion: @escaping (Result<Bool, NetworkingError>) -> Void) {
        guard let mealID = mealID else { return }
        if let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") {
           URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let data = data {
                let jsonDecoder = JSONDecoder()

                
                do {
                    let parsedJSON = try jsonDecoder.decode(DetailEntry.self, from: data)
                        for detail in parsedJSON.meals {
                            self.details = detail
                        }
                    } catch {
                        print(error)
                        return completion(.failure(.troubleDecoding))
                    }
                }
               
               return completion(.success(true))
           }.resume()
        }
    }
}
