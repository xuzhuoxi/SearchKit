//
//  SearchTypeResult.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

/**
 * 单个字(词)的单个检索类型结果
 *
 * @author xuzhuoxi
 *
 */
public struct SearchTypeResult: Comparable {
    fileprivate static let fullMatchingValue: Double = 2.0
    
    /**
     * 检索类型
     *
     * @return 检索类型
     */
    public let searchType: SearchType
    
    /**
     * 检索结果
     *
     * @return 检索结果(匹配度)
     */
    fileprivate(set) public var value: Double = 0
    
    /**
     * 是否为全匹配
     *
     * @return 是true否false
     * @see #fullMatchingValue
     */
    public var isFullMatching: Bool {
        return value >= SearchTypeResult.fullMatchingValue
    }
    
    public init(_ searchType: SearchType) {
        self.searchType = searchType
    }
    
    /**
     * 更新检索结果
     *
     * @param value
     *            检索结果(匹配度)
     *
     * @see #fullMatchingValue
     */
    mutating public func updateBiggerValue(_ value: Double) {
        if (value <= SearchTypeResult.fullMatchingValue && self.value < value) {
            self.value = value
        }
    }

}

public func ==(lhs: SearchTypeResult, rhs: SearchTypeResult) -> Bool {
    return (lhs.isFullMatching == rhs.isFullMatching) && (lhs.value == rhs.value)
}

public func <(lhs: SearchTypeResult, rhs: SearchTypeResult) -> Bool {
    if lhs.isFullMatching != rhs.isFullMatching {
        return lhs.isFullMatching ? false : true
    } else {
        return lhs.value < rhs.value
    }
}
