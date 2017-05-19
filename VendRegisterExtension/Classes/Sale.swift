//
//  Sale.swift
//  VendRegisterExtension
//
//  Created by Vend on 05/08/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//

import Foundation
import Decodable

/// A representation of the current sale
public struct Sale {
    /// The Vend identifier for the sale
    public var identifier: String
    
    /// A customer on the sale if there is one
    public var customer: Customer?
    
    /// The sale totals
    public var totals: Totals
    
    /// The current line items associated with the sale
    public var lineItems: [LineItem]
    
    public init(identifier: String, customer: Customer? = nil, totals: Totals, lineItems: [LineItem] = []) {
        self.identifier = identifier
        self.customer = customer
        self.totals = totals
        self.lineItems = lineItems
    }
}

private enum SaleAttributes {
    static let identifier = "identifier"
    static let customer = "customer"
    static let totals = "totals"
    static let lineItems = "lineItems"
}

extension Sale : Decodable {
    public static func decode(_ json: Any) throws -> Sale {
        return try Sale(identifier: json => KeyPath(SaleAttributes.identifier), customer: json =>? OptionalKeyPath(stringLiteral: SaleAttributes.customer), totals: json => KeyPath(SaleAttributes.totals), lineItems: json => KeyPath(SaleAttributes.lineItems))
    }
}

extension Sale : JSONRepresentable {
    public var asJsonDictionary : [String: Any] {
        var dictionary : [String : Any] = [SaleAttributes.identifier : identifier]
        if let customer = customer {
            dictionary[SaleAttributes.customer] = customer.asJsonDictionary
        }
        dictionary[SaleAttributes.totals] = totals.asJsonDictionary
        dictionary[SaleAttributes.lineItems] = lineItems.map({ $0.asJsonDictionary })
        return dictionary
    }
}

