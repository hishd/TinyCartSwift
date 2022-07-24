//
//  ItemProtocol.swift
//  TinyCart
//
//  Created by Hishara Dilshan on 2022-07-21.
//

import Foundation

open class TinyCartItem: Hashable {
    open var name: String
    open var price: Double
    
    public required init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
    
    public static func == (lhs: TinyCartItem, rhs: TinyCartItem) -> Bool {
        return lhs.name == rhs.name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(price)
    }
}
