//
//  Utils.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 04/11/2021.
//

import Foundation

struct Utils {
    
    public func getUrlOrNil(urlString: String) -> URL? {
        
        if let url = URL(string: urlString){
          
            return url
            
        } else {
            return nil
        }
        
    }
    
}


