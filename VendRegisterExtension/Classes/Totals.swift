//
//  Totals.swift
//  Pods
//
//  Created by Thomas Carey on 8/05/17.
//
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
        guard let tax = try Decimal(string: json => KeyPath(TotalsAttributes.tax)) else {
            throw VendRegisterExtensionError.failedDecimalConversion(attribute: TotalsAttributes.tax, value: try json => KeyPath(TotalsAttributes.tax))
        }
        guard let price = try Decimal(string: json => KeyPath(TotalsAttributes.price)) else {
            throw VendRegisterExtensionError.failedDecimalConversion(attribute: TotalsAttributes.price, value: try json => KeyPath(TotalsAttributes.price))
        }
        guard let paid = try Decimal(string: json => KeyPath(TotalsAttributes.paid)) else {
            throw VendRegisterExtensionError.failedDecimalConversion(attribute: TotalsAttributes.paid, value: try json => KeyPath(TotalsAttributes.paid))
        }
        guard let toPay = try Decimal(string: json => KeyPath(TotalsAttributes.toPay)) else {
            throw VendRegisterExtensionError.failedDecimalConversion(attribute: TotalsAttributes.toPay, value: try json => KeyPath(TotalsAttributes.toPay))
        }
        return Totals(tax: tax, price: price, paid: paid, toPay: toPay)
    }
}

extension Totals : JSONRepresentable {
    public var asJsonDictionary : [String: Any] {
        return [TotalsAttributes.tax: "\(tax)", TotalsAttributes.price: "\(price)", TotalsAttributes.paid: "\(paid)", TotalsAttributes.toPay: "\(toPay)"]
    }
}

