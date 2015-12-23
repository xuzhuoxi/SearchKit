//
//  Reflector.swift
//  SwiftReflector
//
//  Created by Víctor on 23/8/14.
//  Copyright (c) 2014 Víctor Berga. All rights reserved.
//

import Foundation

public class Reflector<T:NSObject> {
    
    lazy public var name: String              = self.loadName()
    lazy public var properties: Array<String> = self.loadProperties()
    lazy public var methods: Array<String>    = self.loadMethods()
    
    private let rawPropertiesCount:UInt32
    private let rawProperties: UnsafeMutablePointer<objc_property_t>
    private let rawMethodscount:UInt32
    private let rawMethods: UnsafeMutablePointer<Method>
    
    private let `class`:NSObject.Type
    
    public init() {
        var count: UInt32       = 0
        
        self.`class`            = T.self
        self.rawProperties      = class_copyPropertyList(self.`class`, &count)
        self.rawPropertiesCount = count
        self.rawMethods         = class_copyMethodList(self.`class`, &count)
        self.rawMethodscount    = count
    }
    
    deinit {
        free(self.rawProperties)
        free(self.rawMethods)
    }
    
    public func createInstance() -> T {
        return T()
    }
    
    public class func createInstance(className:String) -> AnyObject? {
        return SRClassBuilder.createInstanceFromString(className)
    }
    
    public func execute(code: (`self`:T) -> (), instance:T) {
        code(`self`: instance)
    }
    
    public func execute<U>(code: (`self`:T) -> U, instance:T) -> U {
        return code(`self`: instance)
    }
    
    private func loadName() -> String {
//        return NSString(UTF8String: class_getName(self.`class`))
        return String(UTF8String: class_getName(self.`class`))!
    }
    
    private func loadProperties() -> Array<String> {
        var propertyNames : [String]  = []
        let intCount                  = Int(self.rawPropertiesCount)
        
        for var i = 0; i < intCount; i++ {
            let property : objc_property_t  = self.rawProperties[i]
//            let propertyName                = NSString(UTF8String: property_getName(property))
            let propertyName                = String(UTF8String: property_getName(property))
            propertyNames.append(propertyName!)
        }
        return propertyNames
    }
    
    private func loadMethods() -> Array<String> {
        var methodNames : [String]  = []
        let intCount                = Int(self.rawMethodscount)
        
        for var i = 0; i < intCount; i++ {
            let method: Method      = self.rawMethods[i]
            let selector: Selector  = method_getName(method)
//            let methodName          = NSString(UTF8String: sel_getName(selector))
            let methodName          = String(UTF8String: sel_getName(selector))
            methodNames.append(methodName!)
        }
        return methodNames
    }
}
