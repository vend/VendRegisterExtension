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

public enum SaleAttributes {
    public static let identifier = "identifier"
    public static let customer = "customer"
    public static let totals = "totals"
    public static let lineItems = "lineItems"
}

extension Sale : Decodable {
    public static func decode(_ json: Any) throws -> Sale {
        return try Sale(identifier: json => KeyPath(SaleAttributes.identifier), customer: json =>? OptionalKeyPath(stringLiteral: SaleAttributes.customer), totals: json => KeyPath(SaleAttributes.totals), lineItems: json => KeyPath(SaleAttributes.lineItems))
    }
}

extension Sale : JSONRepresentable {
    public var asJsonDictionary : [String: Any] {
        var dictionary : [String : Any] = ["identifier" : identifier]
        if let customer = customer {
            dictionary["customer"] = customer.asJsonDictionary
        }
        dictionary["totals"] = totals.asJsonDictionary
        dictionary["lineItems"] = lineItems.map({ $0.asJsonDictionary })
        return dictionary
    }
}

