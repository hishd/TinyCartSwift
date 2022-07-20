//
//  ItemProtocol.swift
//  TinyCart
//
//  Created by Hishara Dilshan on 2022-07-21.
//

import Foundation

protocol ItemProtocol: Hashable, AnyObject {
    var name: String {get set}
    var price: Double {get set}
}
