//
//  WeightCache.swift
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
public class WeightCache : WeightCacheProtocol, CacheInitProtocol {
    public static var DEFAULT_VALUE: Double {
        return 1.0
    }
    
    init(){}
    
    var cacheName: String!
    var key2weight: Dictionary<String, KeyWeight>!
    
    public func initCache(cacheName: String, _ valueCodingType: ValueCodingTypes?, _ initialCapacity: UInt) {
        self.cacheName = cacheName
        self.key2weight = Dictionary<String, KeyWeight>(minimumCapacity: Int(initialCapacity))
    }
    
    public func supplyData(data: String) {
        if let resource = Resource.getResourceByData(data) {
            supplyResource(resource)
        }
    }
    
    public func supplyResource(path: String) {
        if let resource = Resource.getResource(path) {
            supplyResource(resource)
        }
    }
    
    public func supplyResource(resource: Resource) {
        let size = resource.size()
        for i in 0 ..< size {
            tryCacheKeyValue(resource.getKey(i), resource.getValue(i))
        }
    }
    
    public func supplyData(key: String, value: String) {
        tryCacheKeyValue(key, value)
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
    func tryCacheKeyValue(key: String, _ value: String){
        //子类实现
    }
    
    public final func getCacheName() ->String {
        return cacheName;
    }
    
    public final func isKey(key: String) ->Bool {
        return key2weight!.has(key)
    }
    
    public final func getKeysSize() ->Int {
        return key2weight!.count
    }
    
    public final func getValues(key: String) ->Double {
        if (isKey(key)) {
            return key2weight![key]!.getWeight()
        }
        return WeightCache.DEFAULT_VALUE;
    }
    
    public func toString() ->String {
        return cacheName! + "\n" + String(key2weight)
    }
    
    public static func createWeightCache(cacheName: String, resource: Resource) ->WeightCacheProtocol {
        let rs = WeightCacheImpl()
        rs.initCache(cacheName, nil, UInt(resource.size()))
        rs.supplyResource(resource)
        return rs;
    }
}