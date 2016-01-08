//
//  ChineseCacheImpl.swift
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
class ChineseCacheImpl : ChineseCache, ReflectionProtocol {
    
    /**
     * 1.先检查有效性，不通过则忽略。<br>
     * 2.检查键是否存，进行补充或新增。<br>
     * 3.缓存每个值时，同进行简化反向影射。<br>
     */
    override final func tryCacheKeyValue(resourceKey: String, _ resourceValue: String) -> Bool {
        if resourceKey.isEmpty || resourceValue.isEmpty {
            return false
        }
        if !key2values.has(resourceKey) { // 新增
            key2values[resourceKey] = KeyValues(resourceKey)
        }
        let values = resourceValue.explode(Character("#"))
        for value in values {
            key2values[resourceKey]!.addValue(value)
            cache2DimensionMap(value, key: resourceKey) // 简化反向影射
        }
        return true
    }
    
    static func newInstance() -> ReflectionProtocol {
        return ChineseCacheImpl()
    }
}
