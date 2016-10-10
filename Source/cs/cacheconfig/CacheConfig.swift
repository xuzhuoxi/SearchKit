//
//  CacheConfig.swift
//  SearchKit
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
open class CacheConfig {
    open static let instance: CacheConfig = CacheConfig()
    
    fileprivate var map = Dictionary<String, CacheInfo>()
    fileprivate let currentBundle = Bundle(for: CacheConfig.self)
    
    /**
     * 缓存配置<br>
     * resourcePath路径在实际使用时补充绝对路径，如要取消这种做法，请修改CachePool类<br>
     * initialCapacity的配置应该根据实际情况进行配置<br>
     * 计算方法：缓存数的下一个2的n次幂<br>
     */
    fileprivate init(){
        addConfig(CacheNames.PINYIN_WORD, "SearchKit.CharacterLibraryImpl", true, 32768, "word_pinyin", "UTF-8", ValueCodingType.pinyin_WORD)
        addConfig(CacheNames.WUBI_WORD, "SearchKit.CharacterLibraryImpl", true, 8192, "word_wubi", "UTF-8", ValueCodingType.wubi_WORD)
    }
    
    fileprivate func toMultiPath(_ path: String?) ->[String]? {
        if nil == path || path!.isEmpty {
            return nil
        }
        return path!.components(separatedBy: ";")
    }
    
    fileprivate func addConfig(_ cacheName: String, _ cacheClassName: String, _ isSingleton: Bool, _ initialCapacity: UInt, _ resourcePaths: String?, _ charsetName: String?, _ valueCodingType: ValueCodingType?) {
        if map.has(cacheName) {
            return
        }
        var urls : [URL]? = nil
        if let paths = toMultiPath(resourcePaths) {
            urls = []
            for path in paths {
                urls!.append(currentBundle.url(forResource: path, withExtension: "properites")!)
            }
        }
        map[cacheName] = CacheInfo(cacheName, cacheClassName, isSingleton, initialCapacity, urls, charsetName, valueCodingType: valueCodingType)
    }
    
    fileprivate func addConfig(_ cacheName: String, _ cacheClassName: String, _ isSingleton: Bool, _ initialCapacity: UInt, _ resourceURLs: [URL]?, _ charsetName: String?,  valueCodingClassName: String?) {
        if map.has(cacheName) {
            return
        }
        map[cacheName] = CacheInfo(cacheName, cacheClassName, isSingleton, initialCapacity, resourceURLs, charsetName, valueCodingClassName:valueCodingClassName)
    }
    
    open func supplyConfig(_ cacheName: String, reflectClassName: String, isSingleton: Bool, initialCapacity: UInt, resourceURLs: [URL]?, charsetName: String?, valueCodingClassName: String?) {
        addConfig(cacheName, reflectClassName, isSingleton, initialCapacity, resourceURLs, charsetName, valueCodingClassName: valueCodingClassName)
    }
    
    open func getCacheInfo(_ cacheName : String) ->CacheInfo? {
        return map[cacheName]
    }
    
    open func getCacheInfos() ->[CacheInfo] {
        return [CacheInfo](map.values)
    }
}
