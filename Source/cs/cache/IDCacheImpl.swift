//
//  IDCacheImpl.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/4.
//
//

import Foundation

class IDCacheImpl: IDCache, ReflectionProtocol {
    /**
     * 已有缓存、格式不对、小于等于默认权值的忽略，不加入缓存
     */
    override func tryCacheKeyValue(_ key: String, _ value: String) {
        if key.isEmpty ||  value.isEmpty {
            return
        }
        var valueArr: [String]
        if value.characters.contains("#") {
            valueArr = value.components(separatedBy: "#")
        }else{
            valueArr = [value]
        }
        if key2IDs.has(key) {
            for vl in valueArr {
                if !key2IDs[key]!.contains(vl) {
                    key2IDs[key]!.append(vl)
                }
            }
        }else{
            key2IDs[key] = valueArr
        }
    }
    
    static func newInstance() -> ReflectionProtocol {
        return IDCacheImpl()
    }
}
