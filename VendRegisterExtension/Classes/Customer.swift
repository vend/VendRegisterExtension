//
//  Customer.swift
//  VendRegisterExtension
//
//  Created by Vend on 05/08/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//

import Foundation
import Decodable

/// A customer associated with a sale
public struct Customer {
    
    /// The Vend identifier associated with the customer
    public var identifier: String?
    
    public init(identifier: String?) {
        self.identifier = identifier
    }
}

private enum CustomerAttributes {
    static let identifier = "identifier"
}

extension Customer: Decodable {
    public static func decode(_ json: Any) throws -> Customer {
        return try Customer(identifier: json =>? OptionalKeyPath(stringLiteral: CustomerAttributes.identifier))
    }
}

extension Customer : JSONRepresentable {
    public var asJsonDictionary : [String: Any] {
        var dictionary = [String: Any]()
        if let identifier = identifier {
            dictionary[CustomerAttributes.identifier] = identifier
        }
        return dictionary
    }
}

