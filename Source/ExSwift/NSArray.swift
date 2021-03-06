//
//  NSArray.swift
//  ExSwift
//
//  Created by pNre on 10/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

public extension NSArray {

  /**
   Converts an NSArray object to an OutType[] array containing the items in the NSArray of type OutType.

   - returns: Array of Swift objects
   */
  public func cast <OutType> () -> [OutType] {
    var result = [OutType]()

    for item : Any in self {
      result += Ex.bridgeObjCObject(item) as [OutType]
    }

    return result
  }

  /**
   Flattens a multidimensional NSArray to an OutType[] array
   containing the items in the NSArray that can be bridged from their ObjC type to OutType.

   - returns: Flattened array
   */
  public func flatten <OutType> () -> [OutType] {
    var result = [OutType]()
    let mirror = Mirror(reflecting: self)
    if let mirrorChildrenCollection = AnyRandomAccessCollection(mirror.children) {
      for (_, value) in mirrorChildrenCollection {
        result += Ex.bridgeObjCObject(value) as [OutType]
      }
    }

    return result
  }

  /**
   Flattens a multidimensional NSArray to a [Any].

   - returns: Flattened array
   */
  public func flattenAny () -> [Any] {
    var result = [Any]()

    for item in self {
      if let array = item as? NSArray {
        result += array.flattenAny()
      } else {
        result.append(item)
      }
    }

    return result
  }

}
