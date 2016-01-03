//
//  SearchKeyResult.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

/**
 * 单个汉字(词)的检索结果 别名：键结果
 *
 * @author xuzhuoxi
 *
 */
public struct SearchKeyResult: Comparable {
    private var resultMap = Dictionary<SearchType, SearchTypeResult>()
    
    public let key: String
    
    public let weight: Double
    
    /**
     * 计算是否有完整匹配情况<br>
     *
     * @return 有完整匹配true否false
     */
    public var hasFullMatching: Bool {
        for str in resultMap.values {
            if str.isFullMatching {
                return true
            }
        }
        return false
    }
    
    /**
     * 计算匹配度<br>
     * 把各个检索类别的结果相加<br>
     *
     * @return 匹配度
     */
    public var totalValue : Double {
        var value:Double=0
        for str in resultMap.values {
            value+=str.value
        }
        return value * weight
    }
    
    
    /**
     * 取得全部的检索类别 {@link SearchType}<br>
     *
     * @return 全部的检索类别
     */
    public var searchTypes: [SearchType] {
        return [SearchType](resultMap.keys)
    }
    
    /**
     * 取得全部的检索结果 {@link SearchTypeResult}<br>
     *
     * @return 全部的检索结果
     */
    public var searchTypeResults: [SearchTypeResult] {
        return [SearchTypeResult](resultMap.values)
    }
    
    public init(_ key: String, _ weightCache : WeightCacheProtocol?){
        self.key = key
        self.weight = nil == weightCache ? 1.0 : weightCache!.getValues(key)
    }
    
    /**
     * 更新单个检索类别的匹配值，存储更大的<br>
     *
     * @param searchType
     *            检索类别
     * @param value
     *            匹配值
     */
    mutating public func updateBiggerValue(searchType: SearchType, _ value:Double) {
        if resultMap.has(searchType) {
            resultMap[searchType]!.updateBiggerValue(value)
        }else{
            var str = SearchTypeResult(searchType)
            str.updateBiggerValue(value)
            resultMap[searchType] = str
        }
    }
    
    /**
     * 更新单个字(词)的单个检索类型结果，存储更大的<br>
     *
     * @param str
     *            单个字(词)的单个检索类型结果
     */
    mutating public func updateTypeValue(str:SearchTypeResult) {
        if resultMap.has(str.searchType) {
            resultMap[str.searchType]!.updateBiggerValue(str.value)
        }else{
            resultMap[str.searchType] = str
        }
    }
    
    /**
     * 取得指定检索类别的匹配度<br>
     *
     * @param searchType
     *            检索类别
     * @return 匹配度
     */
    public func getValue(searchType: SearchType) ->Double {
        if resultMap.has(searchType) {
            return resultMap[searchType]!.value
        }else{
            return 0
        }
    }
    
    /**
     * 当相加的SearchKeyResult实例的key{@link #key}与当前相同时，<br>
     * 遍历全部的检索类别和值，进行更新{@link #updateBiggerValue(SearchType, double)}<br>
     *
     * @param skr
     *            单个字(词)的检索结果
     * @return 键相同true否false
     */
    mutating public func addSearchKeyResult(skr:SearchKeyResult) {
        for result in skr.searchTypeResults {
            updateTypeValue(result)
        }
    }
}

public func ==(lhs: SearchKeyResult, rhs: SearchKeyResult) -> Bool {
    return  (lhs.hasFullMatching == rhs.hasFullMatching) && (lhs.totalValue == rhs.totalValue)
}

public func <(lhs: SearchKeyResult, rhs: SearchKeyResult) -> Bool {
    if lhs.hasFullMatching != rhs.hasFullMatching {
        return lhs.hasFullMatching ? false : true
    } else {
        return lhs.totalValue < rhs.totalValue
    }
}