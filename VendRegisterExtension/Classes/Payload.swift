//
//  Payload.swift
//  VendRegisterExtension
//
//  Created by Vend on 24/05/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//
//

import Foundation
import Decodable

/// A representation of the payload
public struct Payload {
    /// The current retailer for the sale
    public var retailer: Retailer
    
    /// The current sale
    public var sale: Sale
    
    public init(retailer: Retailer, sale: Sale) {
        self.retailer = retailer
        self.sale = sale
    }
}

private enum PayloadAttributes {
    static let retailer = "retailer"
    static let sale = "sale"
}

extension Payload : Decodable {
    public static func decode(_ json: Any) throws -> Payload {
        return try Payload(retailer: json => KeyPath(PayloadAttributes.retailer), sale: json => KeyPath(PayloadAttributes.sale))
    }
}

extension Payload : JSONRepresentable {
    public var asJsonDictionary: [String : Any] {
        return [PayloadAttributes.retailer : retailer.asJsonDictionary, PayloadAttributes.sale : sale.asJsonDictionary]
    }
}
