//
//  File.swift
//  Pods
//
//  Created by Thomas Carey on 9/05/17.
//
//

import Foundation
import MobileCoreServices

private enum ExtensionKeys {
    static let operation = "operation"
    static let parameters = "parameters"
}

public enum VendRegisterExtensionOperation {
    
    case addLineItems([LineItem])
    
    var operationName : String {
        switch self {
        case .addLineItems(_): return "addLineItems"
        }
    }
    
    public var extensionItem : NSExtensionItem {
        let item = NSExtensionItem()
        
        var dict = [String: Any]()
        dict[ExtensionKeys.operation] = self.operationName
        
        switch self {
        case .addLineItems(let lineItems):
            dict[ExtensionKeys.parameters] = lineItems.map({ $0.asJsonDictionary })
        }
        
        item.userInfo = dict
        
        return item
    }
    
}
