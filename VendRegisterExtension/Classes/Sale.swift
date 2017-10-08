//
//  Sale.swift
//  VendRegisterExtension
//
//  Created by Vend on 05/08/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//

import Foundation

/// A representation of the current sale
public struct Sale : Decodable {
    /// The Vend identifier for the sale
    public let identifier: String
    
    /// A customer on the sale if there is one
    public let customer: Customer?
    
    /// The sale totals
    public let totals: Totals
    
    /// The current line items associated with the sale
    public let lineItems: [LineItem]
    
    public init(identifier: String, customer: Customer? = nil, totals: Totals, lineItems: [LineItem] = []) {
        self.identifier = identifier
        self.customer = customer
        self.totals = totals
        self.lineItems = lineItems
    }
}
