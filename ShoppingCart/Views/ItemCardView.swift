//
//  ItemCardView.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 19/10/2021.
//

import Foundation
import SwiftUI

struct ItemCardView: View{
    
    var item:Item

    let quantityChange:IQuantityChange
    let utils: Utils = Utils()
    
    @State private var showSheet:Bool = false
    
    
    var body: some View{
        
        VStack(alignment: .leading){
            HStack{
                ZStack(alignment: .topLeading){
                    Image(uiImage: item.product.images[0].thumbnail.url.load())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 56.0, height: 56.0)
                        .onTapGesture {
                            showSheet = true
                        }
                    if item.product.discount != nil {
                        SaleView()
                    }
                     
                }
                .sheet(isPresented: $showSheet, content: {
                    Image(uiImage: item.product.images[0].thumbnail.url.load())
                        .resizable()
                        .scaledToFit()
                })
                
                
                
                
                
                
                VStack(alignment: .leading){
                    Text(item.product.name)
                        .font(Font.custom("Rubik-Regular", size: 14.0))
                        
                    
                    if item.product.availability.isAvailable {
                        
                        Text(item.product.nameExtra)
                            .font(Font.custom("Rubik-Regular", size: 14.0))
                            .foregroundColor(Color("SecondaryTextColor"))
                        
                    } else {
                        
                        Text("Out of stock")
                            .font(Font.custom("Rubik-Regular", size: 14.0))
                            .foregroundColor(Color("OutOfStockTextColor"))
                            
                    }
                    
                    
                }
                .padding()
                //.background(Color.green)
                Spacer()
                
                VStack(alignment: .trailing){
                    
                    if (item.quantity - 1) < 1 {
                        
                        if item.product.discount != nil {
                            Text("kr \(item.discountedDisplayPriceTotal)")
                                .font(Font.custom("Rubik-Medium", size: 14.0))
                                .foregroundColor(Color("AccentActionColor"))
                                .bold()
                        } else {
                            Text("kr \(item.discountedDisplayPriceTotal)")
                                .font(Font.custom("Rubik-Medium", size: 14.0))
                                //.bold()
                        }
                        
                        if item.product.discount != nil {
                            Text("kr \(item.displayPriceTotal)")
                                .font(Font.custom("Rubik-Regular", size: 14.0))
                                .foregroundColor(Color("SecondaryTextColor"))
                                .strikethrough()
                            
                        } else {
                            
                            Text("kr \(item.product.grossUnitPrice)/\(item.product.unitPriceQuantityAbbreviation)")
                                .font(Font.custom("Rubik-Regular", size: 14.0))
                                .foregroundColor(Color("SecondaryTextColor"))
                        }
                        
                    }
                    
                    
                    
                    
                    
                }
                .padding()
                //.background(Color.blue)
                
                
                
                
                if item.availability.isAvailable {
                    
                    if (item.quantity - 1) > 0 {
                        
                        Button(action: {
                            
                            quantityChange.iChangeQuantity(item: item, howMany: -1)
                            
                        }){
                            Image("minus_circle")
                        }
                        .frame(width: 32.0, height: 32.0)
                        
                        Text("\(item.quantity - 1)")
                        
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
                                .foregroundColor(Color("AccentActionColor"))
                            
                        }
                        .frame(width: 32.0, height: 32.0)
                        
                        
                    }
                    
                } else {
                    Button(action: {
                        
                    }) {
                        Image("plus_circle_fill")
                            .foregroundColor(Color("AccentActionColor"))
                            .opacity(0.5)
                    }
                }
                
                
                
            }
            
            Divider()
        }
        .frame(maxWidth: .infinity)
    }
    
}

