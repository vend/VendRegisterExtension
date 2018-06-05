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
    public var tax: NSDecimalNumber
    
    /// The total price on the sale
    public var price: NSDecimalNumber
    
    /// The amount of the sale that has already been paid
    public var paid: NSDecimalNumber
    
    /// The remaining amount on the sale to be paid
    public var toPay: NSDecimalNumber
    
    public init(tax: NSDecimalNumber, price: NSDecimalNumber, paid: NSDecimalNumber, toPay: NSDecimalNumber) {
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
        tax = NSDecimalNumber(string: taxString)
        
        let priceString = try container.decode(String.self, forKey: CodingKeys.price)
        price = NSDecimalNumber(string: priceString)
        
        let paidString = try container.decode(String.self, forKey: CodingKeys.paid)
        paid = NSDecimalNumber(string: paidString)
        
        let toPayString = try container.decode(String.self, forKey: CodingKeys.toPay)
        toPay = NSDecimalNumber(string: toPayString)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumIntegerDigits = 5
        numberFormatter.generatesDecimalNumbers = true
        numberFormatter.numberStyle = .decimal
        
        try container.encode(numberFormatter.string(from: tax), forKey: CodingKeys.tax)
        try container.encode(numberFormatter.string(from: price), forKey: CodingKeys.price)
        try container.encode(numberFormatter.string(from: paid), forKey: CodingKeys.paid)
        try container.encode(numberFormatter.string(from: toPay), forKey: CodingKeys.toPay)
    }
    
}

