//
//  DataService.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 16/10/2021.
//

import Foundation

enum CustomFailures: Error {
    case URLFormatFailed
    case FailedToLoadData
}

struct DataService {
 
    
    func fetchItems(urlString:URL, completion: @escaping (Result<Items?, Error>) -> Void){
        URLSession(configuration: .default).dataTask(with: urlString){ data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                if let items = parseJson(jsonData: data){
                    completion(.success(items))
                } else {
                    completion(.failure(CustomFailures.FailedToLoadData))
                }
            }
            
        }.resume()
    }
    
    
    
    func parseJson(jsonData:Data) -> Items?{
        do {
            
            let decoder = JSONDecoder()
          
            let items = try decoder.decode(Items.self, from: jsonData)

            print(items.items.count)
            return items
            
           
            
        } catch {
            print("Decode error")
            return nil
        }
    }
    
}

