//
//  SearchTypeInfo.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

/**
 * 检索类别信息
 *
 * @author xuzhuoxi
 *
 */
public struct SearchTypeInfo : Equatable {
    /**
     * 检索类型
     */
    public let searchType: SearchType
    /**
     * 检索使用的Cache
     */
    public let chineseCache: ChineseCacheProtocol
    /**
     * 输入处理策略
     */
    public let valueCodingStrategy: ValueCodingStrategyProtocol
    /**
     * 排序使用的权值Cache
     */
    public let weightCache: WeightCacheProtocol?
    
    public init (_ searchType: SearchType, _ chineseCache: ChineseCacheProtocol, _ valueCodingStrategy: ValueCodingStrategyProtocol, _ weightCache: WeightCacheProtocol?){
        self.searchType = searchType
        self.chineseCache = chineseCache
        self.valueCodingStrategy = valueCodingStrategy
        self.weightCache = weightCache
    }
    
    /**
     * 拼音字库
     */
    public static let WORD_PINYIN_SEARCH: SearchTypeInfo = SearchTypeInfo(SearchType.PINYIN_WORD, CachePool.instance.getCache(CacheNames.PINYIN_WORD) as! ChineseCacheProtocol, ValueCodingStrategyFactory.getValueCodingStrategy(ValueCodingType.PINYIN_WORD), nil)
    /**
     * 五笔字库
     */
    public static let WORD_WUBI_SEARCH: SearchTypeInfo = SearchTypeInfo(SearchType.WUBI_WORD, CachePool.instance.getCache(CacheNames.WUBI_WORD) as! ChineseCacheProtocol, ValueCodingStrategyFactory.getValueCodingStrategy(ValueCodingType.WUBI_WORD), nil)
}

public func ==(l:SearchTypeInfo, r:SearchTypeInfo) ->Bool {
    return l.searchType == r.searchType
}
