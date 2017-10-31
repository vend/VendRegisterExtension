//
//  VendRegisterExtensionError.swift
//  VendRegisterExtension
//
//  Created by Vend on 05/08/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//

import Foundation

/// Errors that are thrown in this library
public enum VendRegisterExtensionError: Error, CustomNSError {
    
    /// It was not possible to convert a string value into a decimal
    case failedDecimalConversion(value: String)
    
    case failedDictionaryUnwrapping(identifier: String, value: Any?)
    
    public var errorCode: Int {
        switch self {
        case .failedDecimalConversion(_): return 0
        case .failedDictionaryUnwrapping(_,_): return 1
        }
    }
    
    public var localizedDescription: String {
        switch self {
        case .failedDecimalConversion(_): return "Failed to convert a value to a Decimal number"
        case .failedDictionaryUnwrapping(_,_): return "Failed to unwrap a value into an expected type"
        }
    }
    
    public var errorUserInfo: [String : Any] {
        switch self {
        case .failedDictionaryUnwrapping(let identifier, let value): return [ "identifier": identifier, "value": value ?? "nil"]
        case .failedDecimalConversion(let value): return ["value": value]
        default: return [:]
        }
    }
    
    public static var errorDomain: String {
        return "com.vendhq.VendRegisterExtensionError"
    }
}
