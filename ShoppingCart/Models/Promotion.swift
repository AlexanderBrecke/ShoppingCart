//
//  Promotion.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 19/10/2021.
//

import Foundation

struct Promotion: Codable {
    let title, titleColor, backgroundColor, textColor: String
    let descriptionShort, accessibilityText: String

    enum CodingKeys: String, CodingKey {
        case title
        case titleColor = "title_color"
        case backgroundColor = "background_color"
        case textColor = "text_color"
        case descriptionShort = "description_short"
        case accessibilityText = "accessibility_text"
    }
}
