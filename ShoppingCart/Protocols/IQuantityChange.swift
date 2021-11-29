//
//  IQuantityChange.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 03/11/2021.
//

import Foundation

protocol IQuantityChange {
    
    func iChangeQuantity(item: Item, howMany:Int)
    
}
