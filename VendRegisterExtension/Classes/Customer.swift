//
//  Customer.swift
//  VendRegisterExtension
//
//  Created by Vend on 05/08/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//

import Foundation

/// A customer associated with a sale
public struct Customer : Codable {
    
    /// The Vend identifier associated with the customer
    public var identifier: String?
    
    public init(identifier: String?) {
        self.identifier = identifier
    }
}
