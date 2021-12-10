//
//  ItemCardDescriptionText.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 10/12/2021.
//

import Foundation
import SwiftUI

struct ItemCardDescriptionText: View{
    
    let item:Item
    
    var body: some View {
        VStack(alignment: .leading){
            Text(item.product.name)
                .font(.rubikMedium(size: 14.0))
                
            
            if item.product.availability.isAvailable {
                
                Text(item.product.nameExtra)
                    .font(.rubikRegular(size: 14.0))
                    .foregroundColor(.secondaryTextColor)
                
            } else {
                
                Text("Out of stock")
                    .font(.rubikRegular(size: 14.0))
                    .foregroundColor(.outOfStockTextColor)
                    
            }
            
            
        }
    }
    
}
