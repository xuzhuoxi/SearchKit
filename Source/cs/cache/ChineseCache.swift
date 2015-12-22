//
//  ChineseCache.swift
//  ChineseSearch
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
public class ChineseCache : ChineseCacheProtocol, CacheInitProtocol {
    var cacheName: String!
    var key2values: Dictionary<String, KeyValues>!
    var chineseMap: DimensionMapProtocol!
    var strategy: ValueCodingStrategyProtocol?
    
    init(){}
    
    public func initCache(cacheName: String, _ valueCodingType: ValueCodingTypes?, _ initialCapacity: UInt) {
        self.cacheName = cacheName
        self.key2values = Dictionary<String, KeyValues>(minimumCapacity: Int(initialCapacity))
        self.strategy = nil == valueCodingType ? nil : ValueCodingStrategyFactory.getValueCodingStrategy(valueCodingType!)
        self.chineseMap = DimensionMapBase.createDimensionMap()
    }
    
    public func supplyData(data: String) {
        if let resource = Resource.getResourceByData(data) {
            supplyResource(resource)
        }
    }
    
    public func supplyData(key: String, value: String) {
        tryCacheKeyValue(key, value)
    }
    
    public func supplyResource(path: String) {
        if let resource = Resource.getResource(path) {
            supplyResource(resource)
        }
    }
    
    public func supplyResource(resource: Resource) {
        for i in 0 ..< resource.size() {
            tryCacheKeyValue(resource.getKey(i), resource.getValue(i))
        }
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
            chineseMap.add(dimensionKey, dimensionValue: key);
        }
    }
    
    public func getCacheName() ->String {
        return cacheName;
    }
    
    public func isKey(key: String) ->Bool{
        return key2values.has(key)
    }
    
    public func getValues(key: String) ->[String] {
        if key2values.has(key) {
            return [String](key2values[key]!.getValues())
        }
        return []
    }
    
    public func getKeys(valuePrex: String) ->[String] {
        if let rs = chineseMap.get(valuePrex) {
            return [String](rs)
        }
        return []
    }
    
    public func getKeysSize() ->Int{
        return key2values.count
    }
    
    public func toString() ->String {
        return cacheName + "\n" + String(chineseMap);
    }
    
    public static func createChineseCache(cacheName: String, resource: Resource, valueCodingType: ValueCodingTypes) ->ChineseCacheProtocol {
        let rs = ChineseCacheImpl()
        rs.initCache(cacheName, valueCodingType, UInt(resource.size()))
        rs.supplyResource(resource)
        return rs
    }
}
