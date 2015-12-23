//
//  Reflect.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

public class Reflect {
    private init(){}
    
    public static func toObject(anyClass: String) ->AnyObject? {
        return Reflector.createInstance(anyClass)
    }
}