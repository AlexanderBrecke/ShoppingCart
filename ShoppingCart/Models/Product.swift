//
//  Product.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 16/10/2021.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name, nameExtra: String
    let frontURL: String
    let images: [Image2]
    let grossPrice, grossUnitPrice, unitPriceQuantityAbbreviation, unitPriceQuantityName: String
    let discount: Discount?
    let promotion: Promotion?
    let availability: Availability

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case nameExtra = "name_extra"
        case frontURL = "front_url"
        case images
        case grossPrice = "gross_price"
        case grossUnitPrice = "gross_unit_price"
        case unitPriceQuantityAbbreviation = "unit_price_quantity_abbreviation"
        case unitPriceQuantityName = "unit_price_quantity_name"
        case discount, promotion, availability
    }
}
