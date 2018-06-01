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
public struct Retailer: Codable {
    /// The Vend identifier for the retailer
    public var identifier: String
    
    /// The current retailer domain
    public var domainPrefix: String
    
    public init(identifier: String, domainPrefix: String) {
        self.identifier = identifier
        self.domainPrefix = domainPrefix
    }
}

