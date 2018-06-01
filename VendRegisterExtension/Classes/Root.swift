//
//  Root.swift
//  Pods
//
//  Created by Thomas Carey on 9/10/17.
//

import Foundation

public struct Root : Codable {
    
    public var payload: Payload
    
    public var version: Int
    
    public init(payload: Payload, version: Int) {
        self.payload = payload
        self.version = version
    }
    
}
