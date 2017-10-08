//
//  File.swift
//  VendRegisterExtension
//
//  Created by Vend on 05/08/2017.
//  Copyright (c) 2017 Vend. All rights reserved.
//

import Foundation

private enum ExtensionKeys {
    static let operation = "operation"
    static let parameters = "parameters"
    static let version = "version"
}

/// A convenience enum to type safe the name of the operation and determine which operations are supported by the current Vend Register installation
public enum VendRegisterExtensionOperationName : String {
    case addLineItems
    
    public static func availableOperations(api: Int) -> [VendRegisterExtensionOperationName] {
        var operations = [VendRegisterExtensionOperationName]()
        if api >= 1 {
            operations.append(.addLineItems)
        }
        return operations
    }
}

/// The available operations to third-party integrators. VendRegister will only handle the operations listed below.
public enum VendRegisterExtensionOperation {
    
    /// Add line items to the current sale
    case addLineItems([LineItem])
    
    /// A key to use in the NSExtensionItem so that we can recognise the operation
    var operationName : VendRegisterExtensionOperationName {
        switch self {
        case .addLineItems(_): return .addLineItems
        }
    }
    
    /// Create a NSExtensionItem that is compatible with VendRegister
    public var extensionItem : NSExtensionItem {
        let item = NSExtensionItem()
        
        var dict = [String: Any]()
        dict[ExtensionKeys.operation] = self.operationName.rawValue
        dict[ExtensionKeys.version] = 1.0
        
        switch self {
        case .addLineItems(let lineItems):
            dict[ExtensionKeys.parameters] = lineItems.map({ $0.asDictionary })
        }
        
        item.userInfo = dict
        
        return item
    }
}
