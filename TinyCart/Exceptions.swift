//
//  Exceptions.swift
//  TinyCart
//
//  Created by Hishara Dilshan on 2022-07-21.
//

import Foundation


enum TinyCartException: Error {
    case invalidQuantity
    case itemNotFound
}

extension TinyCartException: LocalizedError {
    public var errorDescription: String? {
        switch(self) {
        case .invalidQuantity:
            return NSLocalizedString("The entered quantity is not valid", comment: "Invalid Quantity")
        case .itemNotFound:
            return NSLocalizedString("Item not found inside the cart", comment: "Invalid Item")
        }
    }
}
