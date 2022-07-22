//
//  ItemProtocol.swift
//  TinyCart
//
//  Created by Hishara Dilshan on 2022-07-21.
//

import Foundation

public protocol ItemProtocol: Hashable {
    var name: String {get set}
    var price: Double {get set}
}
