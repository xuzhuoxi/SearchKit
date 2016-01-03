//
//  ChineseSearcherImpl.swift
//  ChineseSearch
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
        CachePool.instance.initSingletonCaches()
    }
//    
//    final func searchWord(input: String, _ max: Int) -> [SearchKeyResult]? {
//        let searchTypes = [SearchType.PINYIN_WORD, SearchType.WUBI_WORD]
//        return trySearch(input, searchTypes, max)
//    }
//    
//    final func searchWords(input: String, _ max: Int) -> [SearchKeyResult]? {
//        let searchTypes = [SearchType.PINYIN_WORDS, SearchType.WUBI_WORDS]
//        return trySearch(input, searchTypes, max)
//    }
    
    final func search(input: String, searchTypes: [SearchType]) -> SearchResult? {
        return tryAdvancedSearch(input, searchTypes, Int.max)
    }
    
    private func trySearch(input:String, _ searchTypes:[SearchType], _ max:Int) ->[SearchKeyResult]? {
        if let newInput = validityInput(input,searchTypes, max) {
            return doSearch(SearchInfo(newInput, searchTypes, max))
        }else{
            return nil
        }
    }
    
    private func tryAdvancedSearch(input:String, _ searchTypes:[SearchType], _ max:Int) ->SearchResult? {
        if let newInput = validityInput(input,searchTypes, max) {
            return searchMutliType(SearchInfo(newInput, searchTypes, max))
        }else{
            return nil
        }
    }
    
    private func validityInput(input: String, _ searchTypes:[SearchType], _ max:Int) ->String? {
        if input.isEmpty || searchTypes.isEmpty || max <= 0 {
            return nil
        }
        let newInput = input.trimmed().lowercaseString
        if newInput.isEmpty {
            return nil
        }
        return newInput
    }
    
    private func doSearch(si:SearchInfo) ->[SearchKeyResult] {
        let sr:SearchResult = searchMutliType(si)
        let rs:[SearchKeyResult]=sr.sortedResults
        if (rs.count < si.maxResultCount) {
            return rs
        } else {
            return rs[0 ..< si.maxResultCount]
        }
    }
    
    /**
    * 真正检索入口
    *
    * @param searchInfo
    *            已经通过验证的检索信息
    * @return
    */
    private func searchMutliType(searchInfo:SearchInfo!) ->SearchResult {
        let types = searchInfo.searchType
        var sr: SearchResult = SearchResult()
        var sti: SearchTypeInfo
        var filteredInput:String
        if (searchInfo.isChineseInput) {
            for type in types {
                sti = SearchConfig.getSearchTypeInfo(type)!
                sti.valueCodingStrategy
                filteredInput = sti.valueCodingStrategy.filter(searchInfo.inputStr)
                if filteredInput.isEmpty {
                    continue
                }
                let codedInputStrs = sti.valueCodingStrategy.translate(filteredInput)
                let newSR:SearchResult = searchOneSearchType(type, codedInputStrs)
                sr.addResult(newSR)
            }
            if (searchInfo.isChineseInput) {
                sr.chineseRegexpMatchingClear(searchInfo.chineseWordsRegexp!)
            }
        } else {
            for type in types {
                sti = SearchConfig.getSearchTypeInfo(type)!
                filteredInput = sti.valueCodingStrategy.filter(searchInfo.inputStr)
                if filteredInput.isEmpty {
                    continue
                }
                let values = searchOneCoded(type, filteredInput)
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
    private func searchOneSearchType(st:SearchType, _ codedInputStrs:[String]) ->SearchResult {
        var sr:SearchResult = SearchResult()
        for codedInputStr in codedInputStrs {
            if codedInputStr.isEmpty {
                continue
            }
            let values = searchOneCoded(st, codedInputStr)
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
    private func searchOneCoded(st:SearchType, _ codedInputStr:String) ->[SearchKeyResult] {
        let sti = SearchConfig.getSearchTypeInfo(st)!
        let cc:ChineseCacheProtocol = sti.chineseCache
        let strategy = sti.valueCodingStrategy
        let str:String = strategy.getSimplifyValue(strategy.filter(codedInputStr))
        let dimensionKeys:[String] = handleSimplifyValue(str) // 低精度检索，快速
//        		 var dimensionKeys:[String] = advancedHandleSimplifyValue(strategy,
//        		 str)// 高精度检索
        var rsMap = Dictionary<String, SearchKeyResult>()
        for dimensionKey in dimensionKeys {
            let keyList = cc.getKeys(dimensionKey)
            for chineseKey in keyList {
                let values = cc.getValues(chineseKey)
                for value in values {
                    let v = StringMatching.computeMatchintResult(StringMatching.matching(value, codedInputStr)!)
                    if (v > 0 && v <= 2) {
                        if !rsMap.has(chineseKey) {
                            rsMap[chineseKey] = SearchKeyResult(chineseKey, sti.weightCache)
                        }
                        rsMap[chineseKey]!.updateBiggerValue(st, v)
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
    private func handleSimplifyValue(simplifyValue:String) ->[String] {
        if simplifyValue.length > 2 { // 截取前两位作为检索，这里可以
            return [simplifyValue.substringToIndex(simplifyValue.startIndex.advancedBy(2))]
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
    private func advancedHandleSimplifyValue(strategy:ValueCodingStrategyProtocol, simplifyValue:String) ->[String] {
        return strategy.getDimensionKeys(simplifyValue)
    }
}