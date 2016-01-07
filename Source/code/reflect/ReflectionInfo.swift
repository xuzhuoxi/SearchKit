//
//  ReflectionInfo.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/1.
//
//

import Foundation

public struct ReflectionInfo {
    public let className: String
    
    public init (className: String) {
        self.className = className
    }
    
    public func classType() ->ReflectionProtocol.Type? {
        return NSClassFromString(className) as? ReflectionProtocol.Type
    }
    
    public func newInstance() ->ReflectionProtocol? {
        if let type = (NSClassFromString(className) as? ReflectionProtocol.Type) {
            return type.newInstance()
        }else {
            return nil
        }
    }
}