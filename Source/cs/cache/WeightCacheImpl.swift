//
//  WeightCacheImpl.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/20.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
class WeightCacheImpl : WeightCache, ReflectionProtocol {
    /**
    * ^[1-9]d*.d*$ //大于等于1浮点数
    */
    static let REGEX_FLOAT_1MORE: String = "^\\+?([1-9]\\d*\\.\\d*|[1-9]\\d*)$"
    private(set) lazy var pattern: SimplePattern = SimplePattern(REGEX_FLOAT_1MORE)
    
    /**
    * 已有缓存、格式不对、小于等于默认权值的忽略，不加入缓存
    */
    override final func tryCacheKeyValue(resourceKey: String, _ resourceValue: String) {
        if key2weight.has(resourceKey) {
            return
        }
        if pattern.isMatch(resourceValue) {
            if let value = resourceValue.toDouble() {
                if value > WeightCacheImpl.DEFAULT_VALUE {
                    key2weight[resourceKey] = KeyWeight(key: resourceKey, weight: value)
                }
            }
        }
    }

    static func newInstance() -> ReflectionProtocol {
        return WeightCacheImpl()
    }
}