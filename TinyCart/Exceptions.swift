//
//  Exceptions.swift
//  TinyCart
//
//  Created by Hishara Dilshan on 2022-07-21.
//

import Foundation


enum TinyCartException: Error {
    case invalidQuantity(message: String = "The entered quantity is not valid")
    case itemNotFound(message: String = "Item not found inside the cart")
}

extension TinyCartException: LocalizedError {
    public var errorDescription: String? {
        switch(self) {
        case .invalidQuantity(let message):
            return NSLocalizedString(message, comment: "Invalid Quantity")
        case .itemNotFound(let message):
            return NSLocalizedString(message, comment: "Invalid Item")
        }
    }
}
