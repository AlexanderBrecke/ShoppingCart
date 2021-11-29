//
//  Availability.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 19/10/2021.
//

import Foundation

struct Availability: Codable {
    let isAvailable: Bool

    enum CodingKeys: String, CodingKey {
        case isAvailable = "is_available"
    }
}
