//
//  Totals.swift
//  VendRegisterExtension
//
//  Created by Vend on 05/08/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//

import Foundation
import Decodable

/// The totals for the sale
public struct Totals {
    
    /// The tax on the sale
    public var tax: Decimal
    
    /// The total price on the sale
    public var price: Decimal
    
    /// The amount of the sale that has already been paid
    public var paid: Decimal
    
    /// The remaining amount on the sale to be paid
    public var toPay: Decimal
    
    public init(tax: Decimal, price: Decimal, paid: Decimal, toPay: Decimal) {
        self.tax = tax
        self.price = price
        self.paid = paid
        self.toPay = toPay
    }
}

private enum TotalsAttributes {
    static let tax = "tax"
    static let price = "price"
    static let paid = "paid"
    static let toPay = "toPay"
}

extension Totals: Decodable {
    public static func decode(_ json: Any) throws -> Totals {
        return try Totals(tax: json => KeyPath(TotalsAttributes.tax),
                          price: json => KeyPath(TotalsAttributes.price),
                          paid: json => KeyPath(TotalsAttributes.paid),
                          toPay: json => KeyPath(TotalsAttributes.toPay))
    }
}

extension Totals : JSONRepresentable {
    public var asJsonDictionary : [String: Any] {
        return [TotalsAttributes.tax: "\(tax)", TotalsAttributes.price: "\(price)", TotalsAttributes.paid: "\(paid)", TotalsAttributes.toPay: "\(toPay)"]
    }
}

