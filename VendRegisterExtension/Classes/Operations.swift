//
//  File.swift
//  Pods
//
//  Created by Thomas Carey on 9/05/17.
//
//

import Foundation

private enum ExtensionKeys {
    static let operation = "operation"
    static let parameters = "parameters"
    static let version = "version"
}

/// The available operations to third-party integrators. VendRegister will only handle the operations listed below.
public enum VendRegisterExtensionOperation {
    
    /// Add line items to the current sale
    case addLineItems([LineItem])
    
    /// A key to use in the NSExtensionItem so that we can recognise the operation
    var operationName : String {
        switch self {
        case .addLineItems(_): return "addLineItems"
        }
    }
    
    /// Create a NSExtensionItem that is compatible with VendRegister
    public var extensionItem : NSExtensionItem {
        let item = NSExtensionItem()
        
        var dict = [String: Any]()
        dict[ExtensionKeys.operation] = self.operationName
        dict[ExtensionKeys.version] = 1.0
        
        switch self {
        case .addLineItems(let lineItems):
            dict[ExtensionKeys.parameters] = lineItems.map({ $0.asJsonDictionary })
        }
        
        item.userInfo = dict
        
        return item
    }
    
}
