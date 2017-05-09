//
//  Sale.swift
//  Pods
//
//  Created by Thomas Carey on 8/05/17.
//
//

import Foundation
import Decodable

public struct Sale {
    public var identifier: String
    public var customer: Customer?
    public var totals: Totals
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

