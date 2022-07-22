//
//  Cart.swift
//  TinyCart
//
//  Created by Hishara Dilshan on 2022-07-21.
//

import Foundation

public class Cart {
    private var cartItems: [AnyHashable: Int] = [:]
    
    public static let shared = Cart()
    
    private init() {}
    
    public func addItem<T>(item: T, qty: Int) throws where T: ItemProtocol {
        if qty <= 0 {
            throw TinyCartException.invalidQuantity()
        }
        
        if let itemQty = cartItems[item] {
            cartItems[item] = itemQty + qty
        } else {
            cartItems[item] = qty
        }
    }
    
    public func updateQuantity<T>(item: T, qty: Int) throws where T: ItemProtocol {
        if qty == 0 {
            throw TinyCartException.invalidQuantity()
        }
        
        guard let itemQty = cartItems[item] else {
            throw TinyCartException.itemNotFound()
        }
        
        cartItems[item] = itemQty + qty
    }
    
    public func removeQuantity<T>(item: T, qty: Int) throws where T: ItemProtocol {
        if qty == 0 {
            throw TinyCartException.invalidQuantity()
        }
        
        guard let itemQty = cartItems[item] else {
            throw TinyCartException.itemNotFound()
        }
        
        if qty > itemQty {
            throw TinyCartException.invalidQuantity(message: "Invalid item quantity, the quantity should be greter than the exisiting quantity")
        }
        
        if qty == itemQty {
            cartItems.removeValue(forKey: item)
        } else {
            cartItems[itemQty] = itemQty - qty
        }
    }
    
    public func removeItem<T>(item: T) throws where T: ItemProtocol {
        guard cartItems[item] != nil else {
            throw TinyCartException.itemNotFound()
        }
        
        cartItems.removeValue(forKey: item)
    }
    
    public func clearCart() {
        cartItems.removeAll()
    }
    
    public func isEmpty() -> Bool {
        return cartItems.isEmpty
    }
    
    public func getItemQty<T>(item: T) throws -> Int where T: ItemProtocol {
        guard let itemQty = cartItems[item] else {
            throw TinyCartException.itemNotFound()
        }
        
        return itemQty
    }
    
    public func getTotalPrice() -> Double {
        return cartItems.reduce(0.0) { partialResult, item in
            partialResult + (Double(item.value) * ((item.key as? ItemProtocol)?.price ?? 0.0))
        }
    }
    
    public func getItemNames() -> [String] {
        return cartItems.map { item in
            (item.key as? ItemProtocol)?.name ?? ""
        }
    }
    
    public func getItemsWithQuantity() -> [AnyHashable: Int] {
        return cartItems
    }
    
    public func getItemCount() -> Int {
        return cartItems.reduce(0) { partialResult, item in
            partialResult + item.value
        }
    }
    
    public func toString() -> String {
        var itemsInformation = ""
        cartItems.forEach { item in
            itemsInformation
                .append(contentsOf:String(format: "Item Name : %@, Price : %.2f, Quantity : %d",
                                          (item.key as? ItemProtocol)?.name ?? "",
                                          (item.key as? ItemProtocol)?.price ?? 0.0,
                                          item.value)
                )
        }
        return itemsInformation
    }
    
}
