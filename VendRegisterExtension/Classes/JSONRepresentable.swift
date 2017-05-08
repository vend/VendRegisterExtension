//
//  JSONRepresentable.swift
//  Pods
//
//  Created by Thomas Carey on 8/05/17.
//
//

import Foundation

public protocol JSONRepresentable {
    var asJsonDictionary : [String: Any] { get }
}
