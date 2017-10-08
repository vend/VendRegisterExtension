//
//  Retailer.swift
//  VendRegisterExtension
//
//  Created by Vend on 24/05/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//
//

import Foundation

/// A representation of the current retailer
public struct Retailer: Decodable {
    /// The Vend identifier for the retailer
    public let identifier: String
    
    /// The current retailer domain
    public let domainPrefix: String
    
    public init(identifier: String, domainPrefix: String) {
        self.identifier = identifier
        self.domainPrefix = domainPrefix
    }
}

