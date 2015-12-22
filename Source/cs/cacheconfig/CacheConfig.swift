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
    
    private var map : Dictionary<String, CacheInfo> = Dictionary<String, CacheInfo>()
    
    
    /**
     * 缓存配置<br>
     * resourcePath路径在实际使用时前置补充了运行时根目录，如要取消这种做法，请修改CachePool类<br>
     * initialCapacity的配置应该根据实际情况进行配置<br>
     * 计算方法：缓存数的下一个2的n次幂<br>
     */
    private init(){
        addConfig(CacheNames.PINYIN_WORD, ChineseCacheImpl.self, "./resource/word_pinyin.properites", "UTF-8", ValueCodingTypes.PINYIN_WORD, true, 32768);
        addConfig(CacheNames.WUBI_WORD, ChineseCacheImpl.self, "./resource/word_wubi.properites", "UTF-8", ValueCodingTypes.WUBI_WORDS, true, 8192);
        addConfig(CacheNames.PINYIN_WORDS, ChineseCacheImpl.self, "./resource/words_pinyin.properites", "UTF-8", ValueCodingTypes.PINYIN_WORDS, true, 131072);
        addConfig(CacheNames.WUBI_WORDS, ChineseCacheImpl.self, "./resource/words_wubi.properites", "UTF-8", ValueCodingTypes.WUBI_WORDS, true, 131072);
        addConfig(CacheNames.WEIGHT, WeightCacheImpl.self, "./resource/words_weight.properites", "UTF-8", nil, true, 16);
    }
    
    private func addConfig(cacheName : String, _ cacheClass : AnyClass, _ resourcePath : String?, _ charsetName : String?, _ valueType : ValueCodingTypes?, _ singleton : Bool, _ initialCapacity : UInt) {
        map[cacheName] = CacheInfo(cacheName: cacheName, myClass: cacheClass, resourcePath: resourcePath, charsetName: charsetName, valueType: valueType, singleton: singleton, initialCapacity: initialCapacity)
    }
    
    
    public func supplyConfig(cacheName: String, cacheClass: AnyClass, resourcePath: String?, charsetName: String?, valueType: ValueCodingTypes?, singleton: Bool, initialCapacity: UInt) {
        addConfig(cacheName, cacheClass, resourcePath, charsetName, valueType, singleton, initialCapacity);
    }
    
    public func getCacheInfo(cacheName : String) ->CacheInfo? {
        return map[cacheName]
    }
    
    public func getCacheInfos() ->[CacheInfo] {
        return Array<CacheInfo>(map.values)
    }
}