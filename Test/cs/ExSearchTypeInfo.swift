//
//  ExSearchTypeInfo.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/8.
//
//

import Foundation
@testable import SearchKit

extension SearchTypeInfo {
    /**
     * 拼音字库
     */
    public static let PINYIN_WORDS_SEARCH: SearchTypeInfo = SearchTypeInfo(SearchType.PINYIN_WORDS, CachePool.instance.getCache(CacheNames.PINYIN_WORDS) as! ChineseCacheProtocol, ValueCodingStrategyFactory.getValueCodingStrategy(ValueCodingType.pinyin_WORDS), CachePool.instance.getCache(CacheNames.WEIGHT) as? WeightCacheProtocol)
    /**
     * 五笔字库
     */
    public static let WUBI_WORDS_SEARCH: SearchTypeInfo = SearchTypeInfo(SearchType.WUBI_WORDS, CachePool.instance.getCache(CacheNames.WUBI_WORDS) as! ChineseCacheProtocol, ValueCodingStrategyFactory.getValueCodingStrategy(ValueCodingType.wubi_WORDS), CachePool.instance.getCache(CacheNames.WEIGHT) as? WeightCacheProtocol)
}
