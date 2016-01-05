//
//  IDCache.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 16/1/4.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
class IDCache: IDCacheProtocol, CacheInitProtocol {
    private(set) var _cacheName: String!
    var key2IDs: Dictionary<String, [String]>!
    
    var cacheName: String {
        return _cacheName
    }
    
    var keysSize: Int {
        return nil == key2IDs ? 0 : key2IDs!.count
    }
    
    final func initCache(cacheName: String, _ valueCodingInstance: ValueCodingStrategyProtocol?, _ initialCapacity: UInt) {
        self._cacheName = cacheName
        self.key2IDs = Dictionary<String, [String]>(minimumCapacity: Int(initialCapacity))
    }
    
    final func supplyData(data: String) {
        if let resource = Resource.getResourceByData(data) {
            supplyResource(resource)
        }
    }
    
    final func supplyData(key: String, value: String) {
        tryCacheKeyValue(key, value)
    }
    
    final func supplyResource(resource: Resource) {
        let size = resource.size
        for i in 0 ..< size {
            tryCacheKeyValue(resource.getKey(i), resource.getValue(i))
        }
    }
    
    final func supplyResource(url: NSURL) {
        if let resource = Resource.getResource(url.path!) {
            supplyResource(resource)
        }
    }
    
    final func isKey(key: String) -> Bool {
        return key2IDs.has(key)
    }
    
    final func getIDs(key: String) -> [String]? {
        return key2IDs[key]
    }
    
    final func toString() ->String {
        return "\(_cacheName)\n\(key2IDs)"
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
    static func createWeightCache(cacheName: String, resource: Resource) ->IDCacheProtocol {
        let rs = IDCacheImpl()
        rs.initCache(cacheName, nil, UInt(resource.size))
        rs.supplyResource(resource)
        return rs;
    }
}