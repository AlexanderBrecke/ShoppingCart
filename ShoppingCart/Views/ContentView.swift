//
//  ContentView.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 16/10/2021.
//

import SwiftUI

let dataService:DataService = DataService()


struct ContentView: View, IQuantityChange {
  
    // Get view model
    @ObservedObject var viewModel = ProductsViewModel()
    
    // Setup functionality for protocol
    func iChangeQuantity(item: Item, howMany: Int) {
        viewModel.changeItemQuantity(id: item.product.id, howMany: howMany)
    }

    
    var body: some View {
        
        // Finite state machine for the application view
        // Define states for loading, error and success
        switch(viewModel.state){
            case Appstate.loading:
                ProgressView()
            
            case Appstate.error:
                Button("Reload"){
                    viewModel.loadCart()
                }
            
            case Appstate.success:
                LazyVStack{
                    ScrollView{
                        ForEach(viewModel.cart ?? [], id: \.self.product.id){ item in
                            ItemCardView(item:item, quantityChange: self)
                        }
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                        viewModel.saveQuantity()
                    }
                    
                    if(viewModel.itemsInCart > 0){
                        HStack{
                            Image("cart")
                                .frame(width: 32.0, height: 32.0)
                            VStack{
                                
                                Text("\(viewModel.itemsInCart) products")
                                    .font(Font.rubikMedium(size: 14.0))
                            }
                            
                            VStack{
                                Text(String(format: "kr %.2f", viewModel.cartPrice))
                                    .font(Font.rubikMedium(size: 14.0))
                            }
                        }
                    }
                }
        }
        
    }
}

