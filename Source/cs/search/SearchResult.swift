//
//  SearchResult.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

/**
 * 检索总结果
 *
 * @author xuzhuoxi
 *
 */
public struct SearchResult {
    private var keyResultMap = Dictionary<String, SearchKeyResult>()
    
    /**
     * 取得当前键结果数量<br>
     *
     * @return 结果数量
     */
    public var resultsSize: Int {
        return keyResultMap.count
    }
    
    /**
     * 取得当前全部的键结果数组<br>
     * 未经排序<br>
     *
     * @return SearchKeyResult数组{@link SearchKeyResult}
     */
    public var results: [SearchKeyResult] {
        return [SearchKeyResult](keyResultMap.values)
    }
    
    /**
     * 取得当前全部键结果数组<br>
     * 已排序，匹配度大在前{@link SearchKeyResult#compareTo(SearchKeyResult)}
     *
     * @return 按匹配度从大到小的数组
     */
    public var sortedResults: [SearchKeyResult] {
        return [SearchKeyResult](keyResultMap.values).sort(>)
    }
    
    /**
     * 与别一个检索结果相加<br>
     * 相加方式:遍历全部SearchKeyResult进行合并<br>
     * 1.有key相同的：{@link SearchKeyResult#addSearchKeyResult(SearchKeyResult)}<br>
     * 2.没有key相同的:直接存起来<br>
     *
     * @param searchResult
     *            另一个检索结果
     */
    mutating public func addResult(searchResult:SearchResult) {
        for result in searchResult.results {
            tryAddKeyResult(result)
        }
    }
    
    /**
     * 与SearchKeyResult实例相加<br>
     * 1.有key相同的：{@link SearchKeyResult#addSearchKeyResult(SearchKeyResult)}<br>
     * 2.没有key相同的:直接存起来<br>
     *
     * @param keyResult
     *            键结果
     */
    mutating public func addKeyResult(keyResult:SearchKeyResult) {
        tryAddKeyResult(keyResult);
    }
    
    /**
     * 进行正则过滤，当输入包含中文时才能使用<br>
     * 与正则表达式不匹配的键结果会被清除<br>
     * {@link String#matches(String)}{@link SearchInfo#getChineseWordsRegexp()}
     *
     * @param regexp
     *            正则表达式
     */
    mutating public func chineseRegexpMatchingClear(regexp:String) {
        var remove: [String] = []
        let sPattern: SimplePattern = SimplePattern(regexp)
        for key in keyResultMap.keys {
            if !sPattern.isMatch(key) {
                remove.append(key)
            }
        }
        for removeKey in remove {
            keyResultMap.removeValueForKey(removeKey)
        }
    }
    
    /**
     * 把一个键结果合并进来
     *
     * @param keyResult
     *            键结果{@link SearchKeyResult}
     */
    mutating private func tryAddKeyResult(keyResult:SearchKeyResult) {
        if keyResultMap.has(keyResult.key) {
            keyResultMap[keyResult.key]!.addSearchKeyResult(keyResult)
        }else{
            keyResultMap[keyResult.key] = keyResult
        }
    }
}