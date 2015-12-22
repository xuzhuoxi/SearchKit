//
//  WubiWordStrategyImpl.swift
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
public class WubiWordStrategyImpl : AbstractWubiStrategy , ValueCodingStrategyProtocol {
    override init() {}
    
    public func getSimplifyValue(value: String) -> String {
        return value
    }
    
    public func getDimensionKeys(simplifyValue: String) -> Array<String> {
        return abstractGetDimensionKeys(simplifyValue);
    }
    
    public func filter(input: String) -> String {
        return wubiFilter(input);
    }
    
    /**
    * 如果输入中包含已编码的中文，返回对应第一个中文的编码<br>
    * 否则截取前4位拼音字符作为返回
    */
    public func translate(filteredInput: String) -> Array<String> {
        if ChineseUtils.hasChinese(filteredInput) {
            let wordWubiMap = CachePool.instance.getCache(CacheNames.WUBI_WORD) as! ChineseCacheProtocol
            for key in filteredInput.characters {
                if ChineseUtils.isChinese(key) { // 是字典中的汉字，返回编码
                    let keyStr = String(key)
                    if wordWubiMap.isKey(keyStr) {
                        return wordWubiMap.getValues(keyStr)
                    }
                }
            }
        }
        return [filteredInput.substringToIndex(filteredInput.startIndex.advancedBy(4))]
    }
    
    /**
    * 简化编码的计算过程：<br>
    * 分别截取从前[1-length]位作为dimensionKeys<br>
    */
    override func computeDimensionKeys(simplifyValue: String) -> Array<String> {
        var rs = [String]()
        for i in 0 ..< simplifyValue.length {
            rs.append(simplifyValue.substringToIndex(simplifyValue.startIndex.advancedBy(i+1)))
        }
        return rs
    }
}