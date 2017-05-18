//
//  LineItem.swift
//  Pods
//
//  Created by Thomas Carey on 8/05/17.
//
//

import Foundation
import Decodable

/// A line item associated with a sale
public struct LineItem {
    /// The Vend identifier for the product
    public var productIdentifier: String
    
    /// The quantity of the product in the sale
    public var quantity: Decimal
    
    /// The unit price for the line item
    public var unitPrice: Decimal
    
    /// The unit tax for the line item
    public var unitTax: Decimal
    
    /// The tax identifier associated with the line item
    public var taxIdentifier: String
    
    /// The name of the line item
    public var name: String
    
    public init(productIdentifier: String, quantity: Decimal, unitPrice: Decimal, unitTax: Decimal, taxIdentifier: String, name: String) {
        self.productIdentifier = productIdentifier
        self.quantity = quantity
        self.unitPrice = unitPrice
        self.unitTax = unitTax
        self.taxIdentifier = taxIdentifier
        self.name = name
    }
}

private enum LineItemAttributes {
    static let productIdentifier = "identifier"
    static let quantity = "quantity"
    static let unitPrice = "unitPrice"
    static let unitTax = "unitTax"
    static let taxIdentifier = "taxIdentifier"
    static let name = "name"
}

extension LineItem: Decodable {
    public static func decode(_ json: Any) throws -> LineItem {
        guard let quantity = try Decimal(string: json => KeyPath(LineItemAttributes.quantity)) else {
            throw VendRegisterExtensionError.failedDecimalConversion(attribute: LineItemAttributes.quantity, value: try json => KeyPath(LineItemAttributes.quantity))
        }
        guard let unitPrice = try Decimal(string: json => KeyPath(LineItemAttributes.unitPrice)) else {
            throw VendRegisterExtensionError.failedDecimalConversion(attribute: LineItemAttributes.unitPrice, value: try json => KeyPath(LineItemAttributes.unitPrice))
        }
        guard let unitTax = try Decimal(string: json => KeyPath(LineItemAttributes.unitTax)) else {
            throw VendRegisterExtensionError.failedDecimalConversion(attribute: LineItemAttributes.unitTax, value: try json => KeyPath(LineItemAttributes.unitTax))
        }
        return try LineItem(productIdentifier: json => KeyPath(LineItemAttributes.productIdentifier), quantity: quantity, unitPrice: unitPrice, unitTax: unitTax, taxIdentifier: json => KeyPath(LineItemAttributes.taxIdentifier), name: json => KeyPath(LineItemAttributes.name))
    }
}


extension LineItem: JSONRepresentable {
    public var asJsonDictionary : [String: Any] {
        return [LineItemAttributes.productIdentifier: productIdentifier, LineItemAttributes.quantity: "\(quantity)", LineItemAttributes.unitPrice: "\(unitPrice)", LineItemAttributes.unitTax: "\(unitTax)", LineItemAttributes.taxIdentifier: taxIdentifier, LineItemAttributes.name : name]
    }
}
