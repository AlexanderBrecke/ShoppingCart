//
//  SaleView.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 04/11/2021.
//

import Foundation
import SwiftUI

struct SaleView: View {
    
    var body: some View {
        
        ZStack{
            
            Triangle()
                .fill(Color("AccentActionColor"))
                .frame(width: 36.0, height: 36.0)
            
            Text("Salg!")
                .rotationEffect(.degrees(-45))
            
        }
        
    }
    
}
