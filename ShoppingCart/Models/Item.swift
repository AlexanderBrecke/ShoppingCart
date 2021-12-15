//
//  Items.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 19/10/2021.
//

import Foundation

struct Items: Codable {
    let items: [Item]
}

struct Item: Codable {
    let product: Product
    var quantity: Int = 0
    let displayPriceTotal, discountedDisplayPriceTotal: String
    let availability: Availability

    enum CodingKeys: String, CodingKey {
        case product
        case displayPriceTotal = "display_price_total"
        case discountedDisplayPriceTotal = "discounted_display_price_total"
        case availability
    }
    
    public mutating func addQuantity(howMany:Int){
        self.quantity += howMany
    }
}
