//
//  SearchKeyResult.swift
//  SearchKit
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
//    private var resultMap = Dictionary<SearchType, SearchTypeResult>()
    private var resultArr = [SearchTypeResult]()
    
    public let key: String
    
    public let weight: Double
    
    /**
     * 计算是否有完整匹配情况<br>
     *
     * @return 有完整匹配true否false
     */
    public var hasFullMatching: Bool {
        for str in resultArr {
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
        for str in resultArr {
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
        var rs = [SearchType]()
        resultArr.each { (str :SearchTypeResult) -> () in
            rs.append(str.searchType)
        }
        return rs
    }
    
    /**
     * 取得全部的检索可用关联信息 {@link SearchType}<br>
     *
     * @return 全部的可用关联信息
     */
    public var associatedNames: [String] {
        var rs = [String]()
        resultArr.each { (str :SearchTypeResult) -> () in
            if let name = str.searchType.associatedName {
                rs.append(name)
            }
        }
        ArrayUtils.cleanRepeat(&rs)
        return rs
    }
    
    /**
     * 取得全部的检索结果 {@link SearchTypeResult}<br>
     *
     * @return 全部的检索结果
     */
    public var searchTypeResults: [SearchTypeResult] {
        return resultArr
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
        if let index = getIndex(searchType) {
            resultArr[index].updateBiggerValue(value)
        }else{
            var str = SearchTypeResult(searchType)
            str.updateBiggerValue(value)
            resultArr.append(str)
        }
        sort()
    }
    
    /**
     * 更新单个字(词)的单个检索类型结果，存储更大的<br>
     *
     * @param str
     *            单个字(词)的单个检索类型结果
     */
    mutating public func updateTypeValue(str:SearchTypeResult) {
        if let index = resultArr.indexOf(str) {
            if str > resultArr[index] {
                resultArr[index] = str
            }
        }else{
            resultArr.append(str)
        }
        sort()
    }
    
    /**
     * 取得指定检索类别的匹配度<br>
     *
     * @param searchType
     *            检索类别
     * @return 匹配度
     */
    public func getValue(searchType: SearchType) ->Double {
        if let index = getIndex(searchType) {
            return resultArr[index].value
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
        sort()
    }
    
    private func getIndex(searchType: SearchType) ->Int? {
        for (index, st) in resultArr.enumerate() {
            if st.searchType == searchType {
                return index
            }
        }
        return nil
    }
    
    mutating private func sort() {
        resultArr.sortInPlace(>)
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