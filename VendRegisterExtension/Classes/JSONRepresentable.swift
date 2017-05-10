//
//  JSONRepresentable.swift
//  Pods
//
//  Created by Thomas Carey on 8/05/17.
//
//

import Foundation

/// A protocol for defining how to convert an object into a dictionary suitable for JSON serialization
public protocol JSONRepresentable {
    
    /// Represent the current instance as a Dictionary
    var asJsonDictionary : [String: Any] { get }
}
