//
//  ChineseCache.swift
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
class ChineseCache : ChineseCacheProtocol, CacheInitProtocol {
    private(set) var _cacheName: String!
    var key2values: Dictionary<String, KeyValues>!
    private(set) var chineseMap: DimensionMapProtocol!
    private(set) var strategy: ValueCodingStrategyProtocol?
    
    var cacheName: String {
        return _cacheName
    }
    
    var keysSize: Int {
        return nil == key2values ? 0 : key2values!.count
    }
    
    final func initCache(cacheName: String, _ valueCodingInstance: ValueCodingStrategyProtocol?, _ initialCapacity: UInt) {
        self._cacheName = cacheName
        self.key2values = Dictionary<String, KeyValues>(minimumCapacity: Int(initialCapacity))
        self.strategy = valueCodingInstance
        self.chineseMap = DimensionMapBase.createDimensionMap()
    }
    
    final func supplyData(data: String) {
        if let resource = Resource.getResourceByData(data) {
            supplyResource(resource)
        }
    }
    
    final func supplyData(key: String, value: String) {
        tryCacheKeyValue(key, value)
    }
    
    final func supplyResource(url: NSURL) {
        if let resource = Resource.getResource(url.path!) {
            supplyResource(resource)
        }
    }
    
    final func supplyResource(resource: Resource) {
        for i in 0 ..< resource.size {
            tryCacheKeyValue(resource.getKey(i), resource.getValue(i))
        }
    }
    
    /**
     * 简化反向影射:<br>
     * 1.简化输入。{@link IValueCodingStrategy#getSimplifyValue}<br>
     * 2.计算多维缓存Key。{@link IValueCodingStrategy#getDimensionKeys} <br>
     * 3.建立缓存key与汉字的影射。<br>
     *
     * @param singleValue
     *            值的简化键
     * @param key
     *            键
     */
    final func cache2DimensionMap(singleValue: String, key: String) {
        let dimensionKeys = strategy!.getDimensionKeys(strategy!.getSimplifyValue(singleValue))// 35%性能占用
        for dimensionKey in dimensionKeys {// 65%性能占用
            chineseMap.add(dimensionKey, dimensionValue: key)
        }
    }
    
    final func isKey(key: String) ->Bool{
        return key2values.has(key)
    }
    
    final func getValues(key: String) ->[String] {
        if key2values.has(key) {
            return [String](key2values[key]!.values)
        }
        return []
    }
    
    final func getKeys(valuePrex: String) ->[String] {
        if let rs = chineseMap.get(valuePrex) {
            return [String](rs)
        }
        return []
    }
    
    final func toString() ->String {
        return "\(_cacheName)\n\(chineseMap)"
    }
    
    /**
     * 尝试缓存一对键值对<br>
     * 先检查有效性，不通过则忽略<br>
     *
     * @param resourceKey
     *            键
     * @param resourceValue
     *            值
     * @return 缓存成功true，否则false.
     */
    func tryCacheKeyValue(resourceKey: String, _ resourceValue: String) ->Bool {
        //子类实现
        return false
    }
    
    static func createChineseCache(cacheName: String, resource: Resource, valueCodingType: ValueCodingType) ->ChineseCacheProtocol {
        let rs = ChineseCacheImpl()
        rs.initCache(cacheName, ValueCodingStrategyFactory.getValueCodingStrategy(valueCodingType), UInt(resource.size))
        rs.supplyResource(resource)
        return rs
    }
}
