//
//  ExCacheConfig.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/3.
//
//

import Foundation
@testable import SearchKit

extension CacheConfig {
    func supplyPinyinWordsConfig(){
        CacheConfig.instance.supplyConfig(CacheNames.PINYIN_WORDS, reflectClassName: "SearchKit.ChineseCacheImpl", isSingleton: true, initialCapacity: 131072, resourceURLs: [ResourcePaths.URL_PINYIN_WORDS], charsetName: "UTF-8", valueCodingClassName: "SearchKit.PinyinWordsStrategyImpl")
    }
    func supplyWubiWordsConfig(){
        CacheConfig.instance.supplyConfig(CacheNames.WUBI_WORDS, reflectClassName: "SearchKit.ChineseCacheImpl", isSingleton: true, initialCapacity: 131072, resourceURLs: [ResourcePaths.URL_WUBI_WORDS], charsetName: "UTF-8", valueCodingClassName: "SearchKit.WubiWordStrategyImpl")
    }
    func supplyWeightWordsConfig(){
        CacheConfig.instance.supplyConfig(CacheNames.WEIGHT, reflectClassName: "SearchKit.WeightCacheImpl", isSingleton: true, initialCapacity: 16, resourceURLs: [ResourcePaths.URL_WEIGHT_WORDS], charsetName: "UTF-8", valueCodingClassName: nil)
    }
}