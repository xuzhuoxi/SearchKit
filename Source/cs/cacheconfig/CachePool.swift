//
//  CachePool.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/19.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
public class CachePool {
    public static let instance  = CachePool()
    
    private var cachePool = Dictionary<String, CacheProtocol>()
    
    /**
    * 初始化全部单例Cache
    */
    public final func initSingletonCaches() {
        let c = CacheConfig.instance.getCacheInfos()
        for ci in c {
            if ci.isSingleton {
                getCache(ci.cacheName)
            }
        }
    }
    
    /**
    * 通过cacheName取得一个实例
    *
    * @param cacheName
    *            Cache名称{@link CacheNames}
    * @return ICache实例
    */
    public final func getCache(cacheName: String) ->CacheProtocol? {
        if let ci = CacheConfig.instance.getCacheInfo(cacheName) {
            if ci.isSingleton {
                let rs: CacheProtocol
                if cachePool.has(cacheName) {
                    rs = cachePool[cacheName]!
                }else{
                    rs = createInstance(ci)
                    cachePool[cacheName] = rs
                }
                return rs
            }else{
                return createInstance(ci)
            }
        }else{
            return nil
        }
    }
    
    private final func createInstance(ci: CacheInfo) ->CacheProtocol {
        let rs: CacheProtocol = ci.reflectClass!.newInstance()!
        if ci.isNeedResource && rs is CacheInitProtocol {
            let initProtocol = rs as! CacheInitProtocol
            initProtocol.initCache(ci.cacheName, ci.valueCodingType, ci.initialCapacity)
            let pathsInfo = ci.resourcePath!
            let paths: [String]
            let char = Character(";")
            if pathsInfo.characters.contains(char) {
                paths = pathsInfo.explode(char)
            }else{
                paths = [pathsInfo]
            }
            for path in paths {
                initProtocol.supplyResource(path)
            }
        }
        return rs
    }
}