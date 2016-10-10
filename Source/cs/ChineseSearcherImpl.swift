//
//  SearchKiterImpl.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
class ChineseSearcherImpl : ChineseSearcherProtocol {
    init(){
//        CachePool.instance.initSingletonCaches()
    }
    
    final func search(_ input: String, searchConfig: SearchConfig) -> SearchResult? {
        return tryAdvancedSearch(input, searchConfig, Int.max)
    }
    
    final func search(_ input: String, searchConfig: SearchConfig, max: Int) -> [SearchKeyResult]? {
        return trySearch(input, searchConfig, max)
    }
    
    fileprivate func tryAdvancedSearch(_ input:String, _ searchConfig: SearchConfig, _ max:Int) ->SearchResult? {
        if let newInput = validityInput(input, searchConfig.searchTypeInfos, max) {
            return searchMutliType(SearchInfo(newInput, searchConfig, max))
        }else{
            return nil
        }
    }
    
    fileprivate func trySearch(_ input:String, _ searchConfig: SearchConfig, _ max:Int) ->[SearchKeyResult]? {
        if let newInput = validityInput(input,searchConfig.searchTypeInfos, max) {
            return doSearch(SearchInfo(newInput, searchConfig, max))
        }else{
            return nil
        }
    }
    
    fileprivate func validityInput(_ input: String, _ searchTypes:[SearchTypeInfo], _ max:Int) ->String? {
        if input.isEmpty || searchTypes.isEmpty || max <= 0 {
            return nil
        }
        let newInput = input.trim().lowercased()
        if newInput.isEmpty {
            return nil
        }
        return newInput
    }
    
    fileprivate func doSearch(_ si:SearchInfo) ->[SearchKeyResult] {
        let sr: SearchResult = searchMutliType(si)
        let rs: [SearchKeyResult] = sr.sortedResults
        if (rs.count < si.maxResultCount) {
            return rs
        } else {
            return [SearchKeyResult](rs[0..<si.maxResultCount])
        }
    }
    
    /**
    * 真正检索入口
    *
    * @param searchInfo
    *            已经通过验证的检索信息
    * @return
    */
    fileprivate func searchMutliType(_ searchInfo:SearchInfo!) ->SearchResult {
        var sr: SearchResult = SearchResult()
        var filteredInput:String
        if (searchInfo.isChineseInput) {
            for typeInfo in searchInfo.searchConfig.searchTypeInfos {
                filteredInput = typeInfo.valueCodingStrategy.filter(searchInfo.inputStr)
                if filteredInput.isEmpty {
                    continue
                }
                let codedInputStrs = typeInfo.valueCodingStrategy.translate(filteredInput)
                let newSR:SearchResult = searchOneSearchType(typeInfo, codedInputStrs)
                sr.addResult(newSR)
            }
            if (searchInfo.isChineseInput) {
                sr.chineseRegexpMatchingClear(searchInfo.chineseWordsRegexp!)
            }
        } else {
            for typeInfo in searchInfo.searchConfig.searchTypeInfos {
                filteredInput = typeInfo.valueCodingStrategy.filter(searchInfo.inputStr)
                if filteredInput.isEmpty {
                    continue
                }
                let values = searchOneCoded(typeInfo, filteredInput)
                for value in values {
                    sr.addKeyResult(value)
                }
            }
        }
        return sr
    }
    
    /**
    * 针对一种检索类型里的全部编码输入进行检索
    *
    * @param st
    *            检索类型
    * @param codedInputStrs
    *            经过编码的输入信息数组
    * @return
    */
    fileprivate func searchOneSearchType(_ sti:SearchTypeInfo, _ codedInputStrs:[String]) ->SearchResult {
        var sr:SearchResult = SearchResult()
        for codedInputStr in codedInputStrs {
            if codedInputStr.isEmpty {
                continue
            }
            let values = searchOneCoded(sti, codedInputStr)
            for value in values {
                sr.addKeyResult(value)
            }
        }
        return sr
    }
    
    /**
    * 针对一种检索类型里的单个编码输入进行检索
    *
    * @param st
    *            检索类型
    * @param codedInputStr
    *            经过编码的输入信息
    * @return
    */
    fileprivate func searchOneCoded(_ sti:SearchTypeInfo, _ codedInputStr:String) ->[SearchKeyResult] {
        let strategy = sti.valueCodingStrategy
        let str:String = strategy.getSimplifyValue(strategy.filter(codedInputStr))
        let dimensionKeys:[String] = handleSimplifyValue(str) // 低精度检索，快速
//        		 var dimensionKeys:[String] = advancedHandleSimplifyValue(strategy,
//        		 str)// 高精度检索
        var rsMap = Dictionary<String, SearchKeyResult>()
        for dimensionKey in dimensionKeys {
            let keyList = sti.chineseCache.getKeys(dimensionKey)
            for chineseKey in keyList {
                let values = sti.chineseCache.getValues(chineseKey)
                for value in values {
                    let v = StringMatching.computeMatchintResult(StringMatching.matching(value, codedInputStr))
                    if (v > 0 && v <= 2) {
                        if !rsMap.has(chineseKey) {
                            rsMap[chineseKey] = SearchKeyResult(chineseKey, sti.weightCache)
                        }
                        rsMap[chineseKey]!.updateBiggerValue(sti.searchType, v)
                    }
                }
            }
        }
        return [SearchKeyResult](rsMap.values)
    }
    
    /**
    * 取最多前两字符作为简化编码<br>
    * 用于检索时范围更小，精确度变低，相对的耗时变短<br>
    *
    * @param simplifyValue
    * @return
    */
    fileprivate func handleSimplifyValue(_ simplifyValue:String) ->[String] {
        if simplifyValue.length > 2 { // 截取前两位作为检索，这里可以
            return [simplifyValue.substring(to: simplifyValue.characters.index(simplifyValue.startIndex, offsetBy: 2))]
        }
        return [simplifyValue]
    }
    
    /**
    * 取得对应可能的简化编码<br>
    * 用于检索时范围更大更精确，相对的耗时变长<br>
    *
    * @param strategy
    * @param simplifyValue
    * @return
    */
    fileprivate func advancedHandleSimplifyValue(_ strategy:ValueCodingStrategyProtocol, simplifyValue:String) ->[String] {
        return strategy.getDimensionKeys(simplifyValue)
    }
}
