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
public class SearchConfig {
    private static let config: Dictionary<SearchTypes,SearchTypeInfo> = SearchConfig.initConfig()
    
    private static func initConfig() ->Dictionary<SearchTypes,SearchTypeInfo> {
        var rs: Dictionary<SearchTypes,SearchTypeInfo> = Dictionary<SearchTypes,SearchTypeInfo>()
        addConfig(&rs,SearchTypes.PINYIN_WORD, CacheNames.PINYIN_WORD, ValueCodingTypes.PINYIN_WORD);
        addConfig(&rs,SearchTypes.PINYIN_WORDS, CacheNames.PINYIN_WORDS, ValueCodingTypes.PINYIN_WORDS);
        addConfig(&rs,SearchTypes.WUBI_WORD, CacheNames.WUBI_WORD, ValueCodingTypes.WUBI_WORDS);
        addConfig(&rs,SearchTypes.WUBI_WORDS, CacheNames.WUBI_WORDS, ValueCodingTypes.WUBI_WORDS);
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
    private static func addConfig(inout map: Dictionary<SearchTypes,SearchTypeInfo>, _ searchType:SearchTypes, _ cacheName:String, _ valueType:ValueCodingTypes) {
        if map.has(searchType) {
            return
        }
        map[searchType] = SearchTypeInfo(searchType, cacheName, valueType)
    }
    
    public static func getSearchTypeInfo(searchType:SearchTypes) ->SearchTypeInfo? {
        return config[searchType]
    }
}
