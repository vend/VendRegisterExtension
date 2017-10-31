//
//  Payload.swift
//  VendRegisterExtension
//
//  Created by Vend on 24/05/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//
//

import Foundation

/// A representation of the payload
public struct Payload: Codable {
    /// The current retailer for the sale
    public let retailer: Retailer
    
    /// The current sale
    public let sale: Sale
    
    public init(retailer: Retailer, sale: Sale) {
        self.retailer = retailer
        self.sale = sale
    }
}

