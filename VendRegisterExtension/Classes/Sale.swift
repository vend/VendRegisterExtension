//
//  Sale.swift
//  VendRegisterExtension
//
//  Created by Vend on 05/08/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//

import Foundation

/// A representation of the current sale
public struct Sale : Codable {
    /// The Vend identifier for the sale
    public var identifier: String
    
    /// A customer on the sale if there is one
    public var customer: Customer?
    
    /// The sale totals
    public var totals: Totals
    
    /// The current line items associated with the sale
    public var lineItems: [LineItem]
    
    /// A note on the sale
    public var note: String?
    
    public init(identifier: String, customer: Customer? = nil, totals: Totals, lineItems: [LineItem] = [], note: String?) {
        self.identifier = identifier
        self.customer = customer
        self.totals = totals
        self.lineItems = lineItems
        self.note = note
    }
}
