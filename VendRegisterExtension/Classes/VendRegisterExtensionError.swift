//
//  VendRegisterExtensionError.swift
//  Pods
//
//  Created by Thomas Carey on 8/05/17.
//
//

import Foundation

public enum VendRegisterExtensionError: Error {
    case failedDecimalConversion(value: String)
}
