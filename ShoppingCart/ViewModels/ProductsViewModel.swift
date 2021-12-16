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
    
    // Initialize variables
    private let defaults = UserDefaults.standard
    private var quantityList:[Int: Int] = [:]
    
    private var currentLoadTry = 0
    private let maxLoadTries = 2
    
    let dataService:DataService = DataService()
    
    @Published var state = Appstate.loading
    @Published var cart: [Item]?
    @Published var itemsInCart: Int = 0
    @Published var cartPrice:Double = 0.00
    
    
    // Load the cart when we start the app
    init(){
        tryLoadCart()
//        loadCart()
    }
    
    // Functions dealing with user defaults
    // Need to be able to save, load and update quantity of items
    // Save: Try to encode the data and set it in the user defaults
    func saveQuantity(){
        guard let data = try? JSONEncoder().encode(quantityList) else {
            return
        }
        
        defaults.set(data, forKey: Constants.SHOPPING_CART_LETTERS)
    }
    
    // Load: See if we can get data from the user defaults
    // Set the loaded data as the value of our variable
    // Then update thequantity
    func loadQuantity(){
        var savedQuantity: [Int: Int]?
        if let data = defaults.data(forKey: Constants.SHOPPING_CART_LETTERS) {
            savedQuantity = try? JSONDecoder().decode([Int:Int].self, from: data)
        }
        
        quantityList = savedQuantity ?? [:]
        updateQuantity()
    }
    
    // Update: Loop through our list of quantities
    // Change the quantity on the item that correlates with the id of current itteration
    func updateQuantity(){
        for item in quantityList {
            changeItemQuantity(id: item.key, howMany: item.value)
        }
    }
    
    // Function to change quantity of an item
    // Need to get the item in the cart to be able to add quantity
    // Then update the items in the cart to reflect the quantity change
    func changeItemQuantity(id: Int, howMany: Int) {
        guard let index = cart?.firstIndex(where: {$0.product.id == id}) else { return }
        self.cart?[index].addQuantity(howMany: howMany)
        updateItemsInCart()
        quantityList[id] = self.cart?[index].quantity
    }
    
    // Function to update information for the cart view
    private func updateItemsInCart(){
        
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
    
    // Function to try and load cart from api
    // If api doesn't work try after a couple of tries
    // load cart from local data
    func tryLoadCart(){
        if(currentLoadTry < maxLoadTries){
            loadCart()
        } else {
            loadCartFromLocalData()
        }
    }
    
    // Function to load the cart from the url
    // Talk to the dataservice to recieve the json and pass the result to the next function
    // Set the app state to error if we get a bad url
    private func loadCart(){
        
        if let urlString = URL(string: Constants.WEB_API_LINK){
            
            dataService.fetchItems(urlString: urlString){
                [weak self] result in
                self?.recieveItems(result: result)
            }
        } else {
            state = Appstate.error
            print("-- URL format failure --  From: ProductsViewModel loadCart")
        }
        currentLoadTry += 1
    }
    
    // Function to fill the item data into the cart variable
    // Set the app state to success or error depending on if we got data to fill or not
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
    
    // Function to load and fill item data into cart variable in case api does not work
    private func loadCartFromLocalData(){
        if let data = dataService.readLocalFile(forName: "LocalData"){
            let items = dataService.parseJson(jsonData: data)
            if items != nil {
                DispatchQueue.main.async { [weak self] in
                    self?.cart = items?.items
                    self?.loadQuantity()
                    self?.state = Appstate.success
                }
            }
        } else {
            print("Error reading data from local file")
            state = Appstate.error
            return
        }
        
    }
    
    
    
}
