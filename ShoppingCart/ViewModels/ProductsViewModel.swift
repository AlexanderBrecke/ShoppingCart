//
//  ProductsViewModel.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 16/10/2021.
//

import Foundation
import SwiftUI


class ProductsViewModel: ObservableObject{
    
    let dataService:DataService = DataService()
    
    @Published var cart: [Item]?
    
    @Published var itemsInCart: Int = 0
    
    @Published var cartPrice:Double = 0.00
    
    init(){
        loadCart()
    }

    
    func changeItemQuantity(index: Int, howMany: Int) {
        
        objectWillChange.send()
        self.cart?[index].addQuantity(howMany: howMany)
        updateItemsInCart()
    }
    
    func updateItemsInCart(){
        
        var inCart: Int = 0
        var price:Double = 0.00
        
        guard let cart = self.cart else {
            return
        }
        
        for item in cart {
            if item.quantity > 1{
                inCart += (item.quantity - 1)
                price += (Double(item.product.grossPrice)!) * (Double(item.quantity - 1))
            }
        }
        
        objectWillChange.send()
        self.itemsInCart = inCart
        self.cartPrice = price
        
    }
    
    
    
    func loadCart(){
        
        if let urlString = URL(string: "https://api.jsonbin.io/b/60832bec4465377a6bc6b6e6"){
            
            dataService.fetchItems(urlString: urlString){
                [weak self] result in
                self?.recieveItems(result: result)
            }
        } else {
            print("-- URL format failure --  From: ProductsViewModel loadCart")
        }
    }
    
    private func recieveItems(result: Result<Items?, Error>) {
        switch result{
        case .success(let items):
            DispatchQueue.main.async { [weak self] in
                self?.cart = items?.items
            }
        case .failure(let error):
            print(error)
        }
    }
    
    
    
    
}
