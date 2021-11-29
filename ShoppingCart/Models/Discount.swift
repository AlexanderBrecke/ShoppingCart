//
//  Discount.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 19/10/2021.
//

import Foundation

struct Discount: Codable {
    let isDiscounted: Bool
    let undiscountedGrossPrice, undiscountedGrossUnitPrice, descriptionShort: String

    enum CodingKeys: String, CodingKey {
        case isDiscounted = "is_discounted"
        case undiscountedGrossPrice = "undiscounted_gross_price"
        case undiscountedGrossUnitPrice = "undiscounted_gross_unit_price"
        case descriptionShort = "description_short"
    }
}
