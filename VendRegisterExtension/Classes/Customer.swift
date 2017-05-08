//
//  Customer.swift
//  Pods
//
//  Created by Thomas Carey on 8/05/17.
//
//

import Foundation
import Decodable

public struct Customer {
    public var identifier: String?
    
    public init(identifier: String?) {
        self.identifier = identifier
    }
}

public enum CustomerAttributes {
    public static let identifier = "identifier"
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
            dictionary["identifier"] = identifier
        }
        return dictionary
    }
}

