//
//  LineItem.swift
//  VendRegisterExtension
//
//  Created by Vend on 05/08/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//

import Foundation

/// A line item associated with a sale
public struct LineItem: Codable {
    /// The Vend identifier for the product
    public let identifier: String
    
    /// The quantity of the product in the sale
    public let quantity: Decimal
    
    /// The unit price for the line item
    public let unitPrice: Decimal
    
    /// The unit tax for the line item
    public let unitTax: Decimal
    
    /// The tax identifier associated with the line item
    public let taxIdentifier: String
    
    /// The name of the line item
    public let name: String
    
    public init(identifier: String, quantity: Decimal, unitPrice: Decimal, unitTax: Decimal, taxIdentifier: String, name: String) {
        self.identifier = identifier
        self.quantity = quantity
        self.unitPrice = unitPrice
        self.unitTax = unitTax
        self.taxIdentifier = taxIdentifier
        self.name = name
    }
    
    enum CodingKeys: CodingKey {
        case identifier
        case quantity
        case unitPrice
        case unitTax
        case taxIdentifier
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(String.self, forKey: CodingKeys.identifier)
    
        let quantityString = try container.decode(String.self, forKey: CodingKeys.quantity)
        if let value = Decimal(string: quantityString) {
            quantity = value
        } else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: quantityString)
        }
        let unitPriceString = try container.decode(String.self, forKey: CodingKeys.unitPrice)
        if let value = Decimal(string: unitPriceString) {
            unitPrice = value
        } else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: unitPriceString)
        }
        let unitTaxString = try container.decode(String.self, forKey: CodingKeys.unitTax)
        if let value = Decimal(string: unitTaxString) {
            unitTax = value
        } else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: unitTaxString)
        }
        
        taxIdentifier = try container.decode(String.self, forKey: CodingKeys.taxIdentifier)
        name = try container.decode(String.self, forKey: CodingKeys.name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(identifier, forKey: CodingKeys.identifier)
        try container.encode("\(quantity)", forKey: CodingKeys.quantity)
        try container.encode("\(unitPrice)", forKey: CodingKeys.unitPrice)
        try container.encode("\(unitTax)", forKey: CodingKeys.unitTax)
        try container.encode(taxIdentifier, forKey: CodingKeys.taxIdentifier)
        try container.encode(name, forKey: CodingKeys.name)
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

extension LineItem: DictionaryRepresentable {
    public var asDictionary : [String: Any] {
        return [LineItemAttributes.productIdentifier: identifier, LineItemAttributes.quantity: "\(quantity)", LineItemAttributes.unitPrice: "\(unitPrice)", LineItemAttributes.unitTax: "\(unitTax)", LineItemAttributes.taxIdentifier: taxIdentifier, LineItemAttributes.name : name]
    }
}

