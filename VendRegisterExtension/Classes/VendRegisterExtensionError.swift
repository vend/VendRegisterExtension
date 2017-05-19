//
//  VendRegisterExtensionError.swift
//  VendRegisterExtension
//
//  Created by Vend on 05/08/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//

import Foundation

/// Errors that are thrown in this library
public enum VendRegisterExtensionError: Error {
    
    /// It was not possible to convert a string value into a decimal
    case failedDecimalConversion(value: String)
}
