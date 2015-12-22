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
public class SearchKeyResult: Comparable {
    private var key:String
    private var weight:Double
    private lazy var resultMap: Dictionary<SearchTypes, SearchTypeResult> = Dictionary<SearchTypes, SearchTypeResult>()
    
    public init(_ key: String){
        self.key = key
        let iwc = CachePool.instance.getCache(CacheNames.WEIGHT) as! WeightCacheProtocol
        self.weight = iwc.getValues(key)
    }
    
    public final func getKey() ->String {
        return key
    }
    
    public func getWeight() ->Double {
        return weight
    }
    
    /**
     * 计算是否有完整匹配情况<br>
     *
     * @return 有完整匹配true否false
     */
    public final func hasFullMatching() ->Bool {
        for str in resultMap.values {
            if str.isFullMatching() {
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
    public final func getTotalValue() ->Double {
        var value:Double=0
        for str in resultMap.values {
            value+=str.getValue()
        }
        return value * weight
    }
    
    /**
     * 更新单个检索类别的匹配值，存储更大的<br>
     *
     * @param searchType
     *            检索类别
     * @param value
     *            匹配值
     */
    public func updateBiggerValue(searchType:SearchTypes, _ value:Double) {
        if resultMap.has(searchType) {
            resultMap[searchType]!.updateBiggerValue(value)
        }else{
            let str = SearchTypeResult(searchType)
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
    public func updateTypeValue(str:SearchTypeResult) {
        if resultMap.has(str.getSearchType()) {
            resultMap[str.getSearchType()]!.updateBiggerValue(str.getValue())
        }else{
            resultMap[str.getSearchType()] = str
        }
    }
    
    /**
     * 取得指定检索类别的匹配度<br>
     *
     * @param searchType
     *            检索类别
     * @return 匹配度
     */
    public final func getValue(searchType: SearchTypes) ->Double {
        if resultMap.has(searchType) {
            return resultMap[searchType]!.getValue()
        }else{
            return 0
        }
    }
    
    /**
     * 取得全部的检索类别 {@link SearchTypes}<br>
     *
     * @return 全部的检索类别
     */
    public final func getSearchTypes() ->[SearchTypes] {
        return [SearchTypes](resultMap.keys)
    }
    
    /**
     * 取得全部的检索结果 {@link SearchTypeResult}<br>
     *
     * @return 全部的检索结果
     */
    public final func getSearchTypeResults() ->[SearchTypeResult] {
        return [SearchTypeResult](resultMap.values)
    }
    
    /**
     * 当相加的SearchKeyResult实例的key{@link #key}与当前相同时，<br>
     * 遍历全部的检索类别和值，进行更新{@link #updateBiggerValue(SearchTypes, double)}<br>
     *
     * @param skr
     *            单个字(词)的检索结果
     * @return 键相同true否false
     */
    public final func addSearchKeyResult(skr:SearchKeyResult) {
        for result in skr.getSearchTypeResults() {
            updateTypeValue(result)
        }
    }
}

public func ==(lhs: SearchKeyResult, rhs: SearchKeyResult) -> Bool {
    return  (lhs.hasFullMatching() == rhs.hasFullMatching()) && (lhs.getTotalValue() == rhs.getTotalValue())
}

public func <(lhs: SearchKeyResult, rhs: SearchKeyResult) -> Bool {
    if lhs.hasFullMatching() != rhs.hasFullMatching() {
        return lhs.hasFullMatching() ? false : true
    } else {
        return lhs.getTotalValue() < rhs.getTotalValue()
    }
}
//
//public func >(lhs: SearchKeyResult, rhs: SearchKeyResult) -> Bool {
//    if lhs.hasFullMatching() != rhs.hasFullMatching() {
//        return lhs.hasFullMatching() ? true : false
//    } else {
//        return lhs.getTotalValue() > rhs.getTotalValue()
//    }
//}
//
//public func <=(lhs: SearchKeyResult, rhs: SearchKeyResult) -> Bool {
//    return (lhs < rhs) || (lhs == rhs)
//}
//
//public func >=(lhs: SearchKeyResult, rhs: SearchKeyResult) -> Bool {
//    return (lhs > rhs) || (lhs == rhs)
//}
