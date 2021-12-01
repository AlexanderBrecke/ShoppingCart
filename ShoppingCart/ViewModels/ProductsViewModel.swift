//
//  ProductsViewModel.swift
//  ShoppingCart
//
//  Created by Alexander Brecke on 16/10/2021.
//

import Foundation
import SwiftUI

enum Appstate{
    case loading
    case error
    case success
}


class ProductsViewModel: ObservableObject{
    
    let dataService:DataService = DataService()
    
    private let defaults = UserDefaults.standard
    private var quantityList:[Int] = []
    
    @Published var state = Appstate.loading
    
    @Published var cart: [Item]?
    
    @Published var itemsInCart: Int = 0
    
    @Published var cartPrice:Double = 0.00
    
    init(){
        loadCart()
    }
    
    func updateQuantity(){
        if !quantityList.isEmpty{
            for i in 0 ..< quantityList.count{
                if quantityList[i] > 1 {
                    changeItemQuantity(index: i, howMany: (quantityList[i] - 1))
                }
            }
        }
    }
    
    func saveQuantity(){
        
        var newQuantities: [Int] = []
        
        for item in cart!{
            newQuantities.append(item.quantity)
        }
        
        defaults.set(newQuantities, forKey: "ItemQuantity")
    }
    
    func loadQuantity(){
        let savedQuantity = defaults.object(forKey: "ItemQuantity") as? [Int] ?? [Int]()
        quantityList = savedQuantity;
        updateQuantity()
    }

    
    func changeItemQuantity(index: Int, howMany: Int) {
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
            state = Appstate.error
            print("-- URL format failure --  From: ProductsViewModel loadCart")
        }
    }
    
    private func recieveItems(result: Result<Items?, Error>) {
        switch result{
        case .success(let items):
            DispatchQueue.main.async { [weak self] in
                self?.cart = items?.items
                self?.loadQuantity()
                self?.state = Appstate.success
                
            }
        case .failure(let error):
            state = Appstate.error
            print(error)
        }
    }
    
    
    
    
}
