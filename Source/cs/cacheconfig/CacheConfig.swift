//
//  CacheConfig.swift
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
public class CacheConfig {
    public static let instance: CacheConfig = CacheConfig()
    
    private var map = Dictionary<String, CacheInfo>()
    private let currentBundle = NSBundle(forClass: CacheConfig.self)
    
    /**
     * 缓存配置<br>
     * resourcePath路径在实际使用时补充绝对路径，如要取消这种做法，请修改CachePool类<br>
     * initialCapacity的配置应该根据实际情况进行配置<br>
     * 计算方法：缓存数的下一个2的n次幂<br>
     */
    private init(){
        addConfig(CacheNames.PINYIN_WORD, "ChineseSearch.ChineseCacheImpl", true, 32768, "word_pinyin", "UTF-8", ValueCodingType.PINYIN_WORD)
        addConfig(CacheNames.WUBI_WORD, "ChineseSearch.ChineseCacheImpl", true, 8192, "word_wubi", "UTF-8", ValueCodingType.WUBI_WORD)
    }
    
    private func toMultiPath(path: String?) ->[String]? {
        if nil == path || path!.isEmpty {
            return nil
        }
        return path!.componentsSeparatedByString(";")
    }
    
    private func addConfig(cacheName: String, _ cacheClassName: String, _ isSingleton: Bool, _ initialCapacity: UInt, _ resourcePaths: String?, _ charsetName: String?, _ valueCodingType: ValueCodingType?) {
        if map.has(cacheName) {
            return
        }
        var urls : [NSURL]? = nil
        if let paths = toMultiPath(resourcePaths) {
            urls = []
            for path in paths {
                urls!.append(currentBundle.URLForResource(path, withExtension: "properites")!)
            }
        }
        map[cacheName] = CacheInfo(cacheName, cacheClassName, isSingleton, initialCapacity, urls, charsetName, valueCodingType: valueCodingType)
    }
    
    private func addConfig(cacheName: String, _ cacheClassName: String, _ isSingleton: Bool, _ initialCapacity: UInt, _ resourceURLs: [NSURL]?, _ charsetName: String?,  valueCodingClassName: String?) {
        if map.has(cacheName) {
            return
        }
        map[cacheName] = CacheInfo(cacheName, cacheClassName, isSingleton, initialCapacity, resourceURLs, charsetName, valueCodingClassName:valueCodingClassName)
    }
    
    public func supplyConfig(cacheName: String, reflectClassName: String, isSingleton: Bool, initialCapacity: UInt, resourceURLs: [NSURL]?, charsetName: String?, valueCodingClassName: String?) {
        addConfig(cacheName, reflectClassName, isSingleton, initialCapacity, resourceURLs, charsetName, valueCodingClassName: valueCodingClassName)
    }
    
    public func getCacheInfo(cacheName : String) ->CacheInfo? {
        return map[cacheName]
    }
    
    public func getCacheInfos() ->[CacheInfo] {
        return [CacheInfo](map.values)
    }
}