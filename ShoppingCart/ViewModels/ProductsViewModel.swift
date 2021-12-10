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
    private var quantityList:[Int: Int] = [:]
    
    @Published var state = Appstate.loading
    
    @Published var cart: [Item]?
    
    @Published var itemsInCart: Int = 0
    
    @Published var cartPrice:Double = 0.00
    
    init(){
        loadCart()
    }
    
    func updateQuantity(){
        for item in quantityList {
            changeItemQuantity(id: item.key, howMany: item.value)
        }
    }
    
    func saveQuantity(){
        guard let data = try? JSONEncoder().encode(quantityList) else {
            return
        }
        
        defaults.set(data, forKey: Constants.SHOPPING_CART_LETTERS)
    }
    
    func loadQuantity(){
        var savedQuantity: [Int: Int]?
        if let data = defaults.data(forKey: Constants.SHOPPING_CART_LETTERS) {
            savedQuantity = try? JSONDecoder().decode([Int:Int].self, from: data)
        }
        
        quantityList = savedQuantity ?? [:]
        updateQuantity()
    }
    
    
    func changeItemQuantity(id: Int, howMany: Int) {
        guard let index = cart?.firstIndex(where: {$0.product.id == id}) else { return }
        self.cart?[index].addQuantity(howMany: howMany)
        updateItemsInCart()
        quantityList[id] = self.cart?[index].quantity
    }
    
    func updateItemsInCart(){
        
        var inCart: Int = 0
        var price:Double = 0.00
        
        guard let cart = self.cart else {
            return
        }
        
        for item in cart {
            inCart += item.quantity
            price += (Double(item.product.grossPrice)!) * Double(item.quantity)
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
            DispatchQueue.main.async { [weak self] in
                self?.state = Appstate.error
                print(error)
            }
        }
    }
    
}
