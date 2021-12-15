//
//  Utils.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 04/11/2021.
//

import Foundation

struct Utils {
    
    // Utility function to see if we can get an URL from a string.
    public func getUrlOrNil(urlString: String) -> URL? {
        
        guard let url = URL(string: urlString) else {return nil}
        return url
        
    }
    
}


