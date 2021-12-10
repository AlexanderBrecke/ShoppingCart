//
//  ItemCardView.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 19/10/2021.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct ItemCardView: View{
    
    var item:Item

    let quantityChange:IQuantityChange
    let utils: Utils = Utils()
    
    @State private var showSheet:Bool = false
    
    
    var body: some View{
        
        VStack(alignment: .leading){
            HStack{
                ItemCardImageView(item: item)
                ItemCardDescriptionText(item: item)
                    .padding()
                Spacer()
                ItemCardPriceView(item: item)
                    .padding()
                ItemCardButtonView(item: item, quantityChange: quantityChange)
            }
            
            Divider()
        }
        .frame(maxWidth: .infinity)
    }
    
}

