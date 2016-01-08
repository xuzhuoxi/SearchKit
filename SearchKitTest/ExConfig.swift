//
//  Ex.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/5.
//
//

import Foundation
import SearchKit

private class RC {}

extension CacheNames {
    /**
     * 某个游戏
     */
    public static let AOLA_ID = "AOLA:ID"
    public static let AOLA_PINYIN = "AOLA:PINYIN"
    public static let AOLA_WUBI = "AOLA:WUBI"
    public static let AOLA_WEIGHT = "AOLA:WEIGHT"
    
    /**
     * Dota
     */
    public static let DOTA_ID = "DOTA:ID"
    public static let DOTA_PINYIN = "DOTA:PINYIN"
    public static let DOTA_WUBI = "DOTA:WUBI"
    public static let DOTA_WEIGHT = "DOTA:WEIGHT"
    
    /**
     * 我的世界
     */
    public static let MINECRAFT_ID = "MINECRAFT:ID"
    public static let MINECRAFT_PINYIN = "MINECRAFT:PINYIN"
    public static let MINECRAFT_WUBI = "MINECRAFT:WUBI"
    public static let MINECRAFT_WEIGHT = "MINECRAFT:WEIGHT"
}

extension ResourcePaths {
    /**
     * 某个游戏
     */
    public static let URL_AOLA_ID = ResourcePaths.getProperitesURL(RC.self, name: "Aola_ID")!
    public static let URL_AOLA_PINYIN = ResourcePaths.getProperitesURL(RC.self, name: "Aola_pinyin")!
    public static let URL_AOLA_WUBI = ResourcePaths.getProperitesURL(RC.self, name: "Aola_wubi")!
    public static let URL_AOLA_WEIGHT = ResourcePaths.getProperitesURL(RC.self, name: "Aola_weight")!
    public static let PATH_AOLA_ID = ResourcePaths.URL_AOLA_ID.path!
    public static let PATH_AOLA_PINYIN = ResourcePaths.URL_AOLA_PINYIN.path!
    public static let PATH_AOLA_WUBI = ResourcePaths.URL_AOLA_WUBI.path!
    public static let PATH_AOLA_WEIGHT = ResourcePaths.URL_AOLA_WEIGHT.path!
    
    /**
     * Dota
     */
    public static let URL_DOTA_ID = ResourcePaths.getProperitesURL(RC.self, name: "Dota_ID")!
    public static let URL_DOTA_PINYIN = ResourcePaths.getProperitesURL(RC.self, name: "Dota_pinyin")!
    public static let URL_DOTA_WUBI = ResourcePaths.getProperitesURL(RC.self, name: "Dota_wubi")!
    public static let URL_DOTA_WEIGHT = ResourcePaths.getProperitesURL(RC.self, name: "Dota_weight")!
    public static let PATH_DOTA_ID = ResourcePaths.URL_DOTA_ID.path!
    public static let PATH_DOTA_PINYIN = ResourcePaths.URL_DOTA_PINYIN.path!
    public static let PATH_DOTA_WUBI = ResourcePaths.URL_DOTA_WUBI.path!
    public static let PATH_DOTA_WEIGHT = ResourcePaths.URL_DOTA_WEIGHT.path!
    
    /**
     * 我的世界
     */
    public static let URL_MINECRAFT_ID = ResourcePaths.getProperitesURL(RC.self, name: "Minecraft_ID")!
    public static let URL_MINECRAFT_PINYIN = ResourcePaths.getProperitesURL(RC.self, name: "Minecraft_pinyin")!
    public static let URL_MINECRAFT_WUBI = ResourcePaths.getProperitesURL(RC.self, name: "Minecraft_wubi")!
    public static let URL_MINECRAFT_WEIGHT = ResourcePaths.getProperitesURL(RC.self, name: "Minecraft_weight")!
    public static let PATH_MINECRAFT_ID = ResourcePaths.URL_MINECRAFT_ID.path!
    public static let PATH_MINECRAFT_PINYIN = ResourcePaths.URL_MINECRAFT_PINYIN.path!
    public static let PATH_MINECRAFT_WUBI = ResourcePaths.URL_MINECRAFT_WUBI.path!
    public static let PATH_MINECRAFT_WEIGHT = ResourcePaths.URL_MINECRAFT_WEIGHT.path!
}

extension CacheConfig {
    func supplyAolaConfig(){
        CacheConfig.instance.supplyConfig(CacheNames.AOLA_PINYIN, reflectClassName: "SearchKit.ChineseCacheImpl", isSingleton: true, initialCapacity: 2048, resourceURLs: [ResourcePaths.URL_AOLA_PINYIN], charsetName: "UTF-8", valueCodingClassName: "SearchKit.PinyinWordsStrategyImpl")
        CacheConfig.instance.supplyConfig(CacheNames.AOLA_WUBI, reflectClassName: "SearchKit.ChineseCacheImpl", isSingleton: true, initialCapacity: 2048, resourceURLs: [ResourcePaths.URL_AOLA_WUBI], charsetName: "UTF-8", valueCodingClassName: "SearchKit.WubiWordStrategyImpl")
        CacheConfig.instance.supplyConfig(CacheNames.AOLA_WEIGHT, reflectClassName: "SearchKit.WeightCacheImpl", isSingleton: true, initialCapacity: 2048, resourceURLs: [ResourcePaths.URL_AOLA_WEIGHT], charsetName: "UTF-8", valueCodingClassName: nil)
        CacheConfig.instance.supplyConfig(CacheNames.AOLA_ID, reflectClassName: "SearchKit.IDCacheImpl", isSingleton: true, initialCapacity: 2048, resourceURLs: [ResourcePaths.URL_AOLA_ID], charsetName: "UTF-8", valueCodingClassName: nil)
    }
    
    func supplyDotaConfig(){
        CacheConfig.instance.supplyConfig(CacheNames.DOTA_PINYIN, reflectClassName: "SearchKit.ChineseCacheImpl", isSingleton: true, initialCapacity: 256, resourceURLs: [ResourcePaths.URL_DOTA_PINYIN], charsetName: "UTF-8", valueCodingClassName: "SearchKit.PinyinWordsStrategyImpl")
        CacheConfig.instance.supplyConfig(CacheNames.DOTA_WEIGHT, reflectClassName: "SearchKit.WeightCacheImpl", isSingleton: true, initialCapacity: 256, resourceURLs: [ResourcePaths.URL_DOTA_WEIGHT], charsetName: "UTF-8", valueCodingClassName: nil)
        CacheConfig.instance.supplyConfig(CacheNames.DOTA_ID, reflectClassName: "SearchKit.IDCacheImpl", isSingleton: true, initialCapacity: 256, resourceURLs: [ResourcePaths.URL_DOTA_ID], charsetName: "UTF-8", valueCodingClassName: nil)
    }
    
    func supplyMinecraftConfig(){
        CacheConfig.instance.supplyConfig(CacheNames.MINECRAFT_PINYIN, reflectClassName: "SearchKit.ChineseCacheImpl", isSingleton: true, initialCapacity: 256, resourceURLs: [ResourcePaths.URL_MINECRAFT_PINYIN], charsetName: "UTF-8", valueCodingClassName: "SearchKit.PinyinWordsStrategyImpl")
        CacheConfig.instance.supplyConfig(CacheNames.MINECRAFT_WEIGHT, reflectClassName: "SearchKit.WeightCacheImpl", isSingleton: true, initialCapacity: 256, resourceURLs: [ResourcePaths.URL_MINECRAFT_WEIGHT], charsetName: "UTF-8", valueCodingClassName: nil)
        CacheConfig.instance.supplyConfig(CacheNames.MINECRAFT_ID, reflectClassName: "SearchKit.IDCacheImpl", isSingleton: true, initialCapacity: 256, resourceURLs: [ResourcePaths.URL_MINECRAFT_ID], charsetName: "UTF-8", valueCodingClassName: nil)
    }
}

extension SearchType {
    /**
     * 某个游戏物品 拼音
     */
    public static let AOLA_PINYIN = SearchType(associatedName: CacheNames.AOLA_ID)
    /**
     * 某个游戏物品 五笔
     */
    public static let AOLA_WUBI = SearchType(associatedName: CacheNames.AOLA_ID)
    /**
     * Dota 拼音
     */
    public static let DOTA_PINYIN = SearchType(associatedName: CacheNames.DOTA_ID)
    /**
     * 我的世界 拼音
     */
    public static let MINECRAFT_PINYIN = SearchType(associatedName: CacheNames.MINECRAFT_ID)
}

extension SearchTypeInfo {
    /**
     * 某个游戏物品 拼音检索
     */
    public static let AOLA_PINYIN_SEARCH: SearchTypeInfo = SearchTypeInfo(SearchType.AOLA_PINYIN, CachePool.instance.getCache(CacheNames.AOLA_PINYIN) as! ChineseCacheProtocol, ValueCodingStrategyFactory.getValueCodingStrategy(ValueCodingType.PINYIN_WORDS), CachePool.instance.getCache(CacheNames.AOLA_WEIGHT) as? WeightCacheProtocol)
    /**
     * 某个游戏物品 五笔检索
     */
    public static let AOLA_WUBI_SEARCH: SearchTypeInfo = SearchTypeInfo(SearchType.AOLA_WUBI, CachePool.instance.getCache(CacheNames.AOLA_WUBI) as! ChineseCacheProtocol, ValueCodingStrategyFactory.getValueCodingStrategy(ValueCodingType.WUBI_WORDS), CachePool.instance.getCache(CacheNames.AOLA_WEIGHT) as? WeightCacheProtocol)
    
    /**
     * Dota 拼音检索
     */
    public static let DOTA_PINYIN_SEARCH: SearchTypeInfo = SearchTypeInfo(SearchType.DOTA_PINYIN, CachePool.instance.getCache(CacheNames.DOTA_PINYIN) as! ChineseCacheProtocol, ValueCodingStrategyFactory.getValueCodingStrategy(ValueCodingType.PINYIN_WORDS), CachePool.instance.getCache(CacheNames.DOTA_WEIGHT) as? WeightCacheProtocol)
    
    /**
     * 我的世界 拼音检索
     */
    public static let MINECRAFT_PINYIN_SEARCH: SearchTypeInfo = SearchTypeInfo(SearchType.MINECRAFT_PINYIN, CachePool.instance.getCache(CacheNames.MINECRAFT_PINYIN) as! ChineseCacheProtocol, ValueCodingStrategyFactory.getValueCodingStrategy(ValueCodingType.PINYIN_WORDS), CachePool.instance.getCache(CacheNames.MINECRAFT_WEIGHT) as? WeightCacheProtocol)
}