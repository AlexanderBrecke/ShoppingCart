//
//  DataService.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 16/10/2021.
//

import Foundation

// Enum of custom failures
enum CustomFailures: Error {
    case URLFormatFailed
    case FailedToLoadData
}

struct DataService {
 
    // Function to fetch items from a api url
    // Give either nullable items or an error
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
    
    // Function to parse json data into nullable items
    // If we can decode items from the json, return the items, else return nil
    func parseJson(jsonData:Data) -> Items?{
        
        do {
            let items = try JSONDecoder().decode(Items.self, from: jsonData)
            print(items.items.count)
            return items
        } catch {
            print("Decode error")
            return nil
        }
    }
    
}

