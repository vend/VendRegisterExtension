//
//  Totals.swift
//  VendRegisterExtension
//
//  Created by Vend on 05/08/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//

import Foundation

/// The totals for the sale
public struct Totals : Codable {
    
    /// The tax on the sale
    public let tax: Decimal
    
    /// The total price on the sale
    public let price: Decimal
    
    /// The amount of the sale that has already been paid
    public let paid: Decimal
    
    /// The remaining amount on the sale to be paid
    public let toPay: Decimal
    
    public init(tax: Decimal, price: Decimal, paid: Decimal, toPay: Decimal) {
        self.tax = tax
        self.price = price
        self.paid = paid
        self.toPay = toPay
    }
    
    enum CodingKeys: CodingKey {
        case tax
        case price
        case paid
        case toPay
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let taxString = try container.decode(String.self, forKey: CodingKeys.tax)
        if let value = Decimal(string: taxString) {
            tax = value
        } else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: taxString)
        }
        let priceString = try container.decode(String.self, forKey: CodingKeys.price)
        if let value = Decimal(string: priceString) {
            price = value
        } else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: priceString)
        }
        let paidString = try container.decode(String.self, forKey: CodingKeys.paid)
        if let value = Decimal(string: paidString) {
            paid = value
        } else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: paidString)
        }
        let toPayString = try container.decode(String.self, forKey: CodingKeys.toPay)
        if let value = Decimal(string: toPayString) {
            toPay = value
        } else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: toPayString)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode("\(tax)", forKey: CodingKeys.tax)
        try container.encode("\(price)", forKey: CodingKeys.price)
        try container.encode("\(paid)", forKey: CodingKeys.paid)
        try container.encode("\(toPay)", forKey: CodingKeys.toPay)
    }
    
}

