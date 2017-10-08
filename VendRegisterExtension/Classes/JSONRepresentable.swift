//
//  JSONRepresentable.swift
//  VendRegisterExtension
//
//  Created by Vend on 05/08/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//

import Foundation

/// A protocol for defining how to convert an object into a dictionary suitable for JSON serialization
public protocol DictionaryRepresentable {
    
    /// Represent the current instance as a Dictionary
    var asDictionary : [String: Any] { get }
}
