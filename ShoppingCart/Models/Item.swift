//
//  Items.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 19/10/2021.
//

import Foundation

struct Items: Codable {
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct Item: Codable {
    let product: Product
    var quantity: Int
    let displayPriceTotal, discountedDisplayPriceTotal: String
    let availability: Availability

    enum CodingKeys: String, CodingKey {
        case product, quantity
        case displayPriceTotal = "display_price_total"
        case discountedDisplayPriceTotal = "discounted_display_price_total"
        case availability
    }
    
    public mutating func addQuantity(howMany:Int){
//        print("ID: \(product.id) -- Quantity WAS: \(quantity)")
        self.quantity += howMany
//        print("ID: \(product.id) -- Quantity Became: \(quantity)")
    }
}
