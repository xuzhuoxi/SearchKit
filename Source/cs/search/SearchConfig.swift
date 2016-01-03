//
//  SearchConfig.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

/**
 * 检索类别信息配置
 *
 * @author xuzhuoxi
 *
 */
public struct SearchConfig {
    private static let config = SearchConfig.initConfig()
    
    private static func initConfig() ->Dictionary<SearchType,SearchTypeInfo> {
        var rs: Dictionary<SearchType,SearchTypeInfo> = Dictionary<SearchType,SearchTypeInfo>()
        addConfig(&rs,SearchType.PINYIN_WORD, CacheNames.PINYIN_WORD, ValueCodingType.PINYIN_WORD, nil)
        addConfig(&rs,SearchType.WUBI_WORD, CacheNames.WUBI_WORD, ValueCodingType.WUBI_WORDS, nil)
        
//        addConfig(&rs,SearchType.PINYIN_WORDS, CacheNames.PINYIN_WORDS, ValueCodingType.PINYIN_WORDS)
//        addConfig(&rs,SearchType.WUBI_WORDS, CacheNames.WUBI_WORDS, ValueCodingType.WUBI_WORDS)
        return rs
    }
    
    /**
     *
     * @param searchType
     *            检索类型
     * @param cacheName
     *            检索用到的Cache名称
     * @param valueType
     *            输入处理类型
     * @param maxResultCount
     *            最大返回量
     */
    private static func addConfig(inout map: Dictionary<SearchType,SearchTypeInfo>, _ searchType:SearchType, _ cacheName:String, _ valueType:ValueCodingType, _ weightCache: WeightCacheProtocol?) {
        if map.has(searchType) {
            return
        }
        map[searchType] = SearchTypeInfo(searchType, CachePool.instance.getCache(cacheName) as! ChineseCacheProtocol, ValueCodingStrategyFactory.getValueCodingStrategy(valueType),weightCache)
    }
    
    public static func getSearchTypeInfo(searchType:SearchType) ->SearchTypeInfo? {
        return config[searchType]
    }
}
