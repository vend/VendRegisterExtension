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
    public let taxIdentifier: String?
    
    /// The name of the line item
    public let name: String
    
    public init(identifier: String, quantity: Decimal, unitPrice: Decimal, unitTax: Decimal, taxIdentifier: String?, name: String) {
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
        if container.contains(CodingKeys.taxIdentifier) {
            taxIdentifier = try container.decode(String?.self, forKey: CodingKeys.taxIdentifier)
        } else {
            taxIdentifier = nil
        }
        
        name = try container.decode(String.self, forKey: CodingKeys.name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(identifier, forKey: CodingKeys.identifier)
        try container.encode("\(quantity)", forKey: CodingKeys.quantity)
        try container.encode("\(unitPrice)", forKey: CodingKeys.unitPrice)
        try container.encode("\(unitTax)", forKey: CodingKeys.unitTax)
        if let taxIdentifier = taxIdentifier {
            try container.encode(taxIdentifier, forKey: CodingKeys.taxIdentifier)
        }
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
        var dictionary: [String: Any] = [LineItemAttributes.productIdentifier: identifier, LineItemAttributes.quantity: "\(quantity)", LineItemAttributes.unitPrice: "\(unitPrice)", LineItemAttributes.unitTax: "\(unitTax)", LineItemAttributes.name : name]
        if let taxIdentifier = taxIdentifier {
            dictionary[LineItemAttributes.taxIdentifier] = taxIdentifier
        }
        return dictionary
    }
    
    public init(dictionary: [String: Any]) throws {
        guard let identifierValue = dictionary[LineItemAttributes.productIdentifier] as? String else {
            throw VendRegisterExtensionError.failedDictionaryUnwrapping(identifier: LineItemAttributes.productIdentifier, value: dictionary[LineItemAttributes.productIdentifier])
        }
        identifier = identifierValue
        
        guard let quantityString = dictionary[LineItemAttributes.quantity] as? String else {
            throw VendRegisterExtensionError.failedDictionaryUnwrapping(identifier: LineItemAttributes.quantity, value: dictionary[LineItemAttributes.quantity])
        }
        if let value = Decimal(string: quantityString) {
            quantity = value
        } else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: quantityString)
        }
        guard let unitPriceString = dictionary[LineItemAttributes.unitPrice] as? String else {
            throw VendRegisterExtensionError.failedDictionaryUnwrapping(identifier: LineItemAttributes.unitPrice, value: dictionary[LineItemAttributes.unitPrice])
        }
        if let value = Decimal(string: unitPriceString) {
            unitPrice = value
        } else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: unitPriceString)
        }
        guard let unitTaxString = dictionary[LineItemAttributes.unitTax] as? String else {
            throw VendRegisterExtensionError.failedDictionaryUnwrapping(identifier: LineItemAttributes.unitTax, value: dictionary[LineItemAttributes.unitTax])
        }
        if let value = Decimal(string: unitTaxString) {
            unitTax = value
        } else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: unitTaxString)
        }
        
        taxIdentifier = dictionary[LineItemAttributes.taxIdentifier] as? String
        
        guard let nameValue = dictionary[LineItemAttributes.name] as? String else {
            throw VendRegisterExtensionError.failedDictionaryUnwrapping(identifier: LineItemAttributes.name, value: dictionary[LineItemAttributes.name])
        }
        name = nameValue
    }
}

