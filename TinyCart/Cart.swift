//
//  Cart.swift
//  TinyCart
//
//  Created by Hishara Dilshan on 2022-07-21.
//

import Foundation

public class Cart {
    private var cartItems: [BaseCartItem: Int] = [:]
    
    public static let shared = Cart()
    
    private init() {}
    
    private let queue = DispatchQueue(label: "TinyCartQueue", qos: .userInitiated)
    
    public func addItem<T>(item: T, qty: Int) throws where T: BaseCartItem {
        if qty <= 0 {
            throw TinyCartException.invalidQuantity()
        }
        
        queue.async {
            if let itemQty = self.cartItems[item] {
                self.cartItems[item] = itemQty + qty
                NSLog("Item quantity updated in cart")
            } else {
                self.cartItems[item] = qty
                NSLog("Item added to cart")
            }
        }
    }
    
    public func setQuantity<T>(item: T, qty: Int) throws where T: BaseCartItem {
        try queue.sync {
            print(item)
            print(cartItems.first)
            if cartItems[item] == nil {
                throw TinyCartException.itemNotFound()
            }
                
            if qty == 0 {
                self.cartItems.removeValue(forKey: item)
                return
            }
            
            cartItems[item] = qty
            NSLog("Item quantity updated in cart")
        }
    }
    
    public func updateQuantity<T>(item: T, qty: Int) throws where T: BaseCartItem {
        if qty == 0 {
            throw TinyCartException.invalidQuantity()
        }

        try queue.sync {
            guard let itemQty = self.cartItems[item] else {
                throw TinyCartException.itemNotFound()
            }
            
            self.cartItems[item] = itemQty + qty
            NSLog("Item quantity updated in cart")
        }
    }
    
    public func removeQuantity<T>(item: T, qty: Int) throws where T: BaseCartItem {
        if qty == 0 {
            throw TinyCartException.invalidQuantity()
        }
        
        try queue.sync {
            guard let itemQty = self.cartItems[item] else {
                throw TinyCartException.itemNotFound()
            }
            
            if qty > itemQty {
                throw TinyCartException.invalidQuantity(message: "Invalid item quantity, the quantity should be greter than the exisiting quantity")
            }
            
            if qty == itemQty {
                self.cartItems.removeValue(forKey: item)
                NSLog("Removed item from cart")
            } else {
                self.cartItems[item] = itemQty - qty
                NSLog("Removed item quantity from cart")
            }
        }
    }
    
    public func removeItem<T>(item: T) throws where T: BaseCartItem {
        try queue.sync {
            guard self.cartItems[item] != nil else {
                throw TinyCartException.itemNotFound()
            }
            
            self.cartItems.removeValue(forKey: item)
            NSLog("Removed item from cart")
        }
    }
    
    public func clearCart() {
        queue.sync {
            self.cartItems.removeAll()
            NSLog("Cleared all items on cart")
        }
    }
    
    public func isEmpty() -> Bool {
        queue.sync {
            return self.cartItems.isEmpty
        }
    }
    
    public func getItemQty<T>(item: T) throws -> Int where T: BaseCartItem {
        try queue.sync {
            guard let itemQty = self.cartItems[item] else {
                throw TinyCartException.itemNotFound()
            }
            
            return itemQty
        }
    }
    
    public func getTotalPrice() -> Double {
        queue.sync {
            return self.cartItems.reduce(0.0) { partialResult, item in
                partialResult + (Double(item.value) * item.key.price)
            }
        }
    }
    
    public func getItemNames() -> [String] {
        queue.sync {
            return self.cartItems.map { item in
                item.key.name
            }
        }
    }
    
    public func getItemsWithQuantity<T: BaseCartItem>(type: T.Type) -> [T: Int] {
        queue.sync {
            var items: [T: Int] = [:]
            cartItems.forEach { item in
                items[item.key as! T] = item.value
            }
            return items
        }
    }
    
    public func getItemCount() -> Int {
        queue.sync {
            return self.cartItems.reduce(0) { partialResult, item in
                partialResult + item.value
            }
        }
    }
    
    public func toString() -> String {
        queue.sync {
            var itemsInformation = ""
            self.cartItems.forEach { item in
                itemsInformation
                    .append(contentsOf:String(format: "Item Name : %@, Price : %.2f, Quantity : %d",
                                              item.key.name,
                                              item.key.price,
                                              item.value)
                    )
            }
            return itemsInformation
        }
    }
    
}
