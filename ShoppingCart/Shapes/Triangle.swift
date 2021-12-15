//
//  Triangle.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 04/11/2021.
//

import Foundation
import SwiftUI

// Create a triangle for the sales view
struct Triangle:Shape{
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        return path
    }
    
}
