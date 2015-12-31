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
    
    
    /**
     * 缓存配置<br>
     * resourcePath路径在实际使用时前置补充了运行时根目录，如要取消这种做法，请修改CachePool类<br>
     * initialCapacity的配置应该根据实际情况进行配置<br>
     * 计算方法：缓存数的下一个2的n次幂<br>
     */
    private init(){
        addConfig(CacheNames.PINYIN_WORD, "ChineseSearch.ChineseCacheImpl", true, 32768, "/Users/xuzhuoxi/All/sourcestore/xcworkspace/ChineseSearch/Resource/word_pinyin.properites", "UTF-8", ValueCodingType.PINYIN_WORD)
        addConfig(CacheNames.WUBI_WORD, "ChineseSearch.ChineseCacheImpl", true, 8192, "/Users/xuzhuoxi/All/sourcestore/xcworkspace/ChineseSearch/Resource/word_wubi.properites", "UTF-8", ValueCodingType.WUBI_WORDS)
        addConfig(CacheNames.PINYIN_WORDS, "ChineseSearch.ChineseCacheImpl", true, 131072, "/Users/xuzhuoxi/All/sourcestore/xcworkspace/ChineseSearch/Resource/words_pinyin.properites", "UTF-8", ValueCodingType.PINYIN_WORDS)
        addConfig(CacheNames.WUBI_WORDS, "ChineseSearch.ChineseCacheImpl", true, 131072, "/Users/xuzhuoxi/All/sourcestore/xcworkspace/ChineseSearch/Resource/words_wubi.properites", "UTF-8", ValueCodingType.WUBI_WORDS)
        addConfig(CacheNames.WEIGHT, "ChineseSearch.WeightCacheImpl", true, 16, "/Users/xuzhuoxi/All/sourcestore/xcworkspace/ChineseSearch/Resource/words_weight.properites", "UTF-8", nil)
    }
    
    private func addConfig(cacheName: String, _ reflectClassName: String, _ isSingleton: Bool, _ initialCapacity: UInt, _ resourcePath: String?, _ charsetName: String?, _ valueType: ValueCodingType?) {
        map[cacheName] = CacheInfo(cacheName, reflectClassName, isSingleton, initialCapacity, resourcePath, charsetName, valueType)
    }
    
    public func supplyConfig(cacheName: String, reflectClassName: String, isSingleton: Bool, initialCapacity: UInt, resourcePath: String?, charsetName: String?, valueType: ValueCodingType?) {
        addConfig(cacheName, reflectClassName, isSingleton, initialCapacity, resourcePath, charsetName, valueType)
    }
    
    public func getCacheInfo(cacheName : String) ->CacheInfo? {
        return map[cacheName]
    }
    
    public func getCacheInfos() ->[CacheInfo] {
        return [CacheInfo](map.values)
    }
}