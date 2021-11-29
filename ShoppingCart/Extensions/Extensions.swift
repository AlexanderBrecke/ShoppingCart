//
//  Extensions.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 04/11/2021.
//

import Foundation
import UIKit

extension String{
    
    func load() -> UIImage {
        
        do {
            guard let url = URL(string: self) else {
                return UIImage()
            }
            
            let data:Data = try Data(contentsOf: url)
            
            return UIImage(data: data) ?? UIImage()
            
        } catch{
            
        }
        
        return UIImage()
        
    }
    
}


//extension UIImageView {
//
//}
