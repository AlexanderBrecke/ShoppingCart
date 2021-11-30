//
//  ShoppingCartApp.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 16/10/2021.
//

import SwiftUI

@main
struct ShoppingCartApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                    .background(Color("BackgroundColor"))
                    .navigationTitle("Shopping cart")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(StackNavigationViewStyle())

            
        }
    }
}
