//
//  VendRegisterExtensionError.swift
//  Pods
//
//  Created by Thomas Carey on 8/05/17.
//
//

import Foundation

/// Errors that are thrown in this library
public enum VendRegisterExtensionError: Error {
    
    /// It was not possible to convert a string value into a decimal
    case failedDecimalConversion(value: String)
}
