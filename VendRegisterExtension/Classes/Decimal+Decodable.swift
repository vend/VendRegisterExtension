//
//  Decimal+Decodable.swift
//  Pods
//
//  Created by Thomas Carey on 18/05/17.
//
//

import Foundation
import Decodable

extension Decimal: Decodable {
    public static func decode(_ json: Any) throws -> Decimal {
        let stringValue = try String.decode(json)
        if let value = Decimal(string: stringValue) {
            return value
        } else {
            throw VendRegisterExtensionError.failedDecimalConversion(value: stringValue)
        }
    }
}
