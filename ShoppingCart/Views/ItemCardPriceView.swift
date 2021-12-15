//
//  ItemCardPriceView.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 10/12/2021.
//

import Foundation
import SwiftUI

// View to show the price of a specified item
// Only show if the quantity of the item is less than 1
struct ItemCardPriceView: View{
    
    let item:Item
    
    var body: some View {
        VStack(alignment: .trailing){
            
            if item.quantity < 1 {
                
                if item.product.discount != nil {
                    Text("kr \(item.discountedDisplayPriceTotal)")
                        .font(.rubikMedium(size: 14.0))
                        .foregroundColor(.accentAction)
                        .bold()
                } else {
                    Text("kr \(item.discountedDisplayPriceTotal)")
                        .font(.rubikMedium(size: 14.0))
                        //.bold()
                }
                
                if item.product.discount != nil {
                    Text("kr \(item.displayPriceTotal)")
                        .font(.rubikRegular(size: 14.0))
                        .foregroundColor(.secondaryTextColor)
                        .strikethrough()
                    
                } else {
                    
                    Text("kr \(item.product.grossUnitPrice)/\(item.product.unitPriceQuantityAbbreviation)")
                        .font(.rubikRegular(size: 14.0))
                        .foregroundColor(.secondaryTextColor)
                }
                
            }
            
        }
    }
    
}
