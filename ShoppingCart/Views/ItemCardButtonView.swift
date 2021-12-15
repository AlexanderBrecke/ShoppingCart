//
//  ItemCardButtonView.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 10/12/2021.
//

import Foundation
import SwiftUI

// View to show buttons to add or remove quantity of a specified item
// If quantity is less than 1 show only a plus button
// else show a plus and minus button with the quantity in text between
struct ItemCardButtonView: View {
    
    let item:Item
    let quantityChange: IQuantityChange
    
    var body: some View{
        if item.availability.isAvailable {
            
            if item.quantity > 0 {
                
                Button(action: {
                    quantityChange.iChangeQuantity(item: item, howMany: -1)
                }){
                    Image("minus_circle")
                }
                .frame(width: 32.0, height: 32.0)
                
                Text("\(item.quantity)")
                
                Button(action: {
                    quantityChange.iChangeQuantity(item: item, howMany: 1)
                }) {
                    Image("plus_circle")
                }
                .frame(width: 32.0, height: 32.0)
                
            } else {
                Button(action:{
                    quantityChange.iChangeQuantity(item: item, howMany: 1)
                }) {
                    Image("plus_circle_fill")
                        .foregroundColor(.accentAction)
                }
                .frame(width: 32.0, height: 32.0)
                
            }
            
        } else {
            Button(action: {
                
            }) {
                Image("plus_circle_fill")
                    .foregroundColor(.accentAction)
                    .opacity(0.5)
            }
        }
    }
    
}
