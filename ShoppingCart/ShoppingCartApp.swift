//
//  ShoppingCartApp.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 16/10/2021.
//

import SwiftUI
import Foundation

@main
struct ShoppingCartApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                    .background(Color.backgroundAppColor)
                    .navigationTitle("Shopping cart")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(StackNavigationViewStyle())

            
        }
    }
}
