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
class WeightCache : WeightCacheProtocol, CacheInitProtocol {
    static var DEFAULT_VALUE: Double {
        return 1.0
    }
    
    private(set) var cacheName: String!
    var key2weight: Dictionary<String, KeyWeight>!
    
    final func initCache(cacheName: String, _ valueCodingInstance: ValueCodingStrategyProtocol?, _ initialCapacity: UInt) {
        self.cacheName = cacheName
        self.key2weight = Dictionary<String, KeyWeight>(minimumCapacity: Int(initialCapacity))
    }
    
    final func supplyData(data: String) {
        if let resource = Resource.getResourceByData(data) {
            supplyResource(resource)
        }
    }
    
    final func supplyResource(url: NSURL) {
        if let resource = Resource.getResource(url.path!) {
            supplyResource(resource)
        }
    }
    
    final func supplyResource(resource: Resource) {
        let size = resource.size
        for i in 0 ..< size {
            tryCacheKeyValue(resource.getKey(i), resource.getValue(i))
        }
    }
    
    final func supplyData(key: String, value: String) {
        tryCacheKeyValue(key, value)
    }
    
    final func getCacheName() ->String {
        return cacheName;
    }
    
    final func isKey(key: String) ->Bool {
        return key2weight!.has(key)
    }
    
    final func getKeysSize() ->Int {
        return nil == key2weight ? 0 : key2weight!.count
    }
    
    final func getValues(key: String) ->Double {
        if (isKey(key)) {
            return key2weight![key]!.weight
        }
        return WeightCache.DEFAULT_VALUE;
    }
    
    final func toString() ->String {
        return cacheName! + "\n" + String(key2weight)
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
    
    static func createWeightCache(cacheName: String, resource: Resource) ->WeightCacheProtocol {
        let rs = WeightCacheImpl()
        rs.initCache(cacheName, nil, UInt(resource.size))
        rs.supplyResource(resource)
        return rs;
    }
}