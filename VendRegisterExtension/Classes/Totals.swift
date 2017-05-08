//
//  Totals.swift
//  Pods
//
//  Created by Thomas Carey on 8/05/17.
//
//

import Foundation
import Decodable

public struct Totals {
    public var tax: Decimal
    public var price: Decimal
    public var paid: Decimal
    public var toPay: Decimal
    
    public init(tax: Decimal, price: Decimal, paid: Decimal, toPay: Decimal) {
        self.tax = tax
        self.price = price
        self.paid = paid
        self.toPay = toPay
    }
}

public enum TotalsAttributes {
    public static let tax = "tax"
    public static let price = "price"
    public static let paid = "paid"
    public static let toPay = "toPay"
}

extension Totals: Decodable {
    public static func decode(_ json: Any) throws -> Totals {
        guard let tax = try Decimal(string: json => KeyPath(TotalsAttributes.tax)) else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: TotalsAttributes.tax)
        }
        guard let price = try Decimal(string: json => KeyPath(TotalsAttributes.price)) else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: TotalsAttributes.price)
        }
        guard let paid = try Decimal(string: json => KeyPath(TotalsAttributes.paid)) else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: TotalsAttributes.paid)
        }
        guard let toPay = try Decimal(string: json => KeyPath(TotalsAttributes.toPay)) else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: TotalsAttributes.toPay)
        }
        return Totals(tax: tax, price: price, paid: paid, toPay: toPay)
    }
}

extension Totals : JSONRepresentable {
    public var asJsonDictionary : [String: Any] {
        return ["tax": "\(tax)", "price": "\(price)", "paid": "\(paid)", "toPay": "\(toPay)"]
    }
}

