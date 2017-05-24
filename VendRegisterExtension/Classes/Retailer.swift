//
//  Retailer.swift
//  VendRegisterExtension
//
//  Created by Vend on 24/05/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//
//

import Foundation
import Decodable

/// A representation of the current retailer
public struct Retailer {
    /// The Vend identifier for the retailer
    public var identifier: String
    
    /// The current retailer domain
    public var domainPrefix: String
    
    public init(identifier: String, domainPrefix: String) {
        self.identifier = identifier
        self.domainPrefix = domainPrefix
    }
}

private enum RetailerAttributes {
    static let identifier = "identifier"
    static let domainPrefix = "domainPrefix"
}

extension Retailer : Decodable {
    public static func decode(_ json: Any) throws -> Retailer {
        return try Retailer(identifier: json => KeyPath(RetailerAttributes.identifier), domainPrefix: json => KeyPath(RetailerAttributes.domainPrefix))
    }
}

extension Retailer : JSONRepresentable {
    public var asJsonDictionary: [String : Any] {
        return [RetailerAttributes.identifier : identifier, RetailerAttributes.domainPrefix : domainPrefix]
    }
}
