//
//  Image.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 19/10/2021.
//

import Foundation


struct Image2: Codable {
    let thumbnail, large: Large
}

struct Large: Codable {
    let url: String
}
