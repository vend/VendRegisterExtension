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
    /// The Vend identifier for the lineItem (if nil, then this will be considered to be a new lineItem)
    public var lineItemIdentifier: String?
    
    /// The Vend identifier for the product (only editable in new line items)
    public var productIdentifier: String
    
    /// The quantity of the product in the sale (editable on all items)
    public var quantity: NSDecimalNumber
    
    /// The unit price for the line item (editable on all items)
    public var unitPrice: NSDecimalNumber
    
    /// The unit tax for the line item (not editable, value is ignored on new items)
    public var unitTax: NSDecimalNumber
    
    /// A flag to indicate if the price is tax inclusive (not editable, value is ignored on new items)
    public var priceIsTaxInclusive: Bool
    
    /// The tax identifier associated with the line item (not editable, value is ignored on new items)
    public var taxIdentifier: String?
    
    /// The name of the line item (not editable, value is ignored on new items)
    public var name: String
    
    /// The note on the line item (editable on all items)
    public var note: String?
    
    public init(lineItemIdentifier: String?, productIdentifier:String, quantity: NSDecimalNumber, unitPrice: NSDecimalNumber, unitTax: NSDecimalNumber, priceIsTaxInclusive: Bool, taxIdentifier: String?, name: String, note: String?) {
        self.lineItemIdentifier = lineItemIdentifier
        self.productIdentifier = productIdentifier
        self.quantity = quantity
        self.unitPrice = unitPrice
        self.unitTax = unitTax
        self.taxIdentifier = taxIdentifier
        self.name = name
        self.note = note
        self.priceIsTaxInclusive = priceIsTaxInclusive
    }
    
    enum CodingKeys: String, CodingKey {
        case lineItemIdentifier
        case productIdentifier = "identifier" // Compatibility with version 1
        case quantity
        case unitPrice
        case unitTax
        case taxIdentifier
        case priceIsTaxInclusive
        case name
        case note
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if container.contains(CodingKeys.lineItemIdentifier) {
            lineItemIdentifier = try container.decode(String?.self, forKey: CodingKeys.lineItemIdentifier)
        } else {
            lineItemIdentifier = nil
        }
        
        productIdentifier = try container.decode(String.self, forKey: CodingKeys.productIdentifier)
        
        let quantityString = try container.decode(String.self, forKey: CodingKeys.quantity)
        quantity = NSDecimalNumber(string: quantityString)
        let unitPriceString = try container.decode(String.self, forKey: CodingKeys.unitPrice)
        unitPrice = NSDecimalNumber(string: unitPriceString)
        let unitTaxString = try container.decode(String.self, forKey: CodingKeys.unitTax)
        unitTax = NSDecimalNumber(string: unitTaxString)
        if container.contains(CodingKeys.taxIdentifier) {
            taxIdentifier = try container.decode(String?.self, forKey: CodingKeys.taxIdentifier)
        } else {
            taxIdentifier = nil
        }
        if container.contains(CodingKeys.note) {
            note = try container.decode(String?.self, forKey: CodingKeys.note)
        } else {
            note = nil
        }
        if (container.contains(CodingKeys.priceIsTaxInclusive)) {
            priceIsTaxInclusive = try container.decode(Bool.self, forKey: CodingKeys.priceIsTaxInclusive)
        } else {
            priceIsTaxInclusive = false
        }
        name = try container.decode(String.self, forKey: CodingKeys.name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if let identifier = lineItemIdentifier {
            try container.encode(identifier, forKey: CodingKeys.lineItemIdentifier)
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumIntegerDigits = 5
        numberFormatter.generatesDecimalNumbers = true
        numberFormatter.numberStyle = .decimal
        try container.encode(priceIsTaxInclusive, forKey: CodingKeys.priceIsTaxInclusive)
        try container.encode(productIdentifier, forKey: CodingKeys.productIdentifier)
        try container.encode(numberFormatter.string(from: quantity), forKey: CodingKeys.quantity)
        try container.encode(numberFormatter.string(from: unitPrice), forKey: CodingKeys.unitPrice)
        try container.encode(numberFormatter.string(from: unitTax), forKey: CodingKeys.unitTax)
        if let taxIdentifier = taxIdentifier {
            try container.encode(taxIdentifier, forKey: CodingKeys.taxIdentifier)
        }
        try container.encode(name, forKey: CodingKeys.name)
        if let note = note {
            try container.encode(note, forKey: .note)
        }
    }
}

private enum LineItemAttributes {
    static let lineItemIdentifier = "lineItemIdentifier"
    static let productIdentifier = "identifier"
    static let quantity = "quantity"
    static let unitPrice = "unitPrice"
    static let unitTax = "unitTax"
    static let taxIdentifier = "taxIdentifier"
    static let name = "name"
    static let note = "note"
    static let priceIsTaxInclusive = "priceIsTaxInclusive"
}

extension LineItem: DictionaryRepresentable {
    public var asDictionary : [String: Any] {
        var dictionary: [String: Any] = [LineItemAttributes.productIdentifier: productIdentifier, LineItemAttributes.quantity: "\(quantity)", LineItemAttributes.unitPrice: "\(unitPrice)", LineItemAttributes.unitTax: "\(unitTax)", LineItemAttributes.name : name]
        if let taxIdentifier = taxIdentifier {
            dictionary[LineItemAttributes.taxIdentifier] = taxIdentifier
        }
        return dictionary
    }
    
    public init(dictionary: [String: Any]) throws {
        guard let identifierValue = dictionary[LineItemAttributes.productIdentifier] as? String else {
            throw VendRegisterExtensionError.failedDictionaryUnwrapping(identifier: LineItemAttributes.productIdentifier, value: dictionary[LineItemAttributes.productIdentifier])
        }
        productIdentifier = identifierValue
        
        lineItemIdentifier = dictionary[LineItemAttributes.lineItemIdentifier] as? String
        
        guard let quantityString = dictionary[LineItemAttributes.quantity] as? String else {
            throw VendRegisterExtensionError.failedDictionaryUnwrapping(identifier: LineItemAttributes.quantity, value: dictionary[LineItemAttributes.quantity])
        }
        quantity = NSDecimalNumber(string: quantityString)
        guard let unitPriceString = dictionary[LineItemAttributes.unitPrice] as? String else {
            throw VendRegisterExtensionError.failedDictionaryUnwrapping(identifier: LineItemAttributes.unitPrice, value: dictionary[LineItemAttributes.unitPrice])
        }
        unitPrice = NSDecimalNumber(string: unitPriceString)
        guard let unitTaxString = dictionary[LineItemAttributes.unitTax] as? String else {
            throw VendRegisterExtensionError.failedDictionaryUnwrapping(identifier: LineItemAttributes.unitTax, value: dictionary[LineItemAttributes.unitTax])
        }
        unitTax = NSDecimalNumber(string: unitTaxString)
        
        taxIdentifier = dictionary[LineItemAttributes.taxIdentifier] as? String
        
        guard let nameValue = dictionary[LineItemAttributes.name] as? String else {
            throw VendRegisterExtensionError.failedDictionaryUnwrapping(identifier: LineItemAttributes.name, value: dictionary[LineItemAttributes.name])
        }
        name = nameValue
        
        note = dictionary[LineItemAttributes.note] as? String
        
        priceIsTaxInclusive = dictionary[LineItemAttributes.priceIsTaxInclusive] as? Bool ?? false
    }
}

