//
//  PinyinWordStrategyImpl.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/19.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
public class PinyinWordStrategyImpl : AbstractValueCoding , ValueCodingStrategyProtocol {
    override init(){}
    
    public func getSimplifyValue(value: String) -> String {
        return value
    }
    
    public func getDimensionKeys(simplifyValue: String) -> Array<String> {
        return abstractGetDimensionKeys(simplifyValue)
    }
    
    /**
     * 过滤输入字符串，保留中文字符和拼音字符<br>
     */
    public func filter(input: String) -> String {
        sb.removeAll(keepCapacity: true)
        for c in input.characters {
            if ChineseUtils.isChinese(c) || ChineseUtils.isPinyinChar(c) {
                sb.append(c)
            }
        }
        return sb
    }
    
    /**
     * 如果输入中包含已编码的中文，返回对应第一个中文的全部编码<br>
     * 否则返回源字符串
     */
    public func translate(filteredInput: String) -> Array<String> {
        if ChineseUtils.hasChinese(filteredInput) {
            let wordPinyinMap = CachePool.instance.getCache(CacheNames.PINYIN_WORD) as! ChineseCacheProtocol
            for key in filteredInput.characters {
                if !ChineseUtils.isChinese(key) {
                    continue
                }
                let keyStr = String(key)
                if wordPinyinMap.isKey(keyStr) {
                    return wordPinyinMap.getValues(keyStr)
                }
            }
        }
        return [filteredInput]
    }
    
    /**
     * 简化编码的计算过程：<br>
     * 分别截取从前[1-length]位作为dimensionKeys
     */
    override func computeDimensionKeys(simplifyValue: String) -> Array<String> {
        var rs = [String]()
        for i in 0 ..< simplifyValue.length {
            rs.append(simplifyValue.substringToIndex(simplifyValue.startIndex.advancedBy(i+1)))
        }
        return rs
    }
}