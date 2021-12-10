//
//  Colors + Extensions.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 10/12/2021.
//

import SwiftUI

extension Color {
    
    static var secondaryTextColor = Color("SecondaryTextColor")
    static var primaryTextColor = Color("PrimaryTextColor")
    static var backgroundAppColor = Color("BackgroundColor")
    static var outOfStockTextColor = Color("OutOfStockTextColor")
    static var accentAction = Color("AccentActionColor")
    
}

extension Font {
    
    static func rubikRegular(size: CGFloat) -> Font {
        return Font.custom("Rubik-Regular", size: size)
    }
    
    static func rubikMedium(size: CGFloat) -> Font {
        return Font.custom("Rubik-Medium", size: size)
    }
    
}
