//
//  WubiWordStrategyImpl.swift
//  SearchKit
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
class WubiWordStrategyImpl: AbstractWubiStrategy, ValueCodingStrategyProtocol, ReflectionProtocol {
    
    final func getSimplifyValue(_ value: String) ->String {
        return value
    }
    
    final func getDimensionKeys(_ simplifyValue: String) ->[String] {
        return abstractGetDimensionKeys(simplifyValue);
    }
    
    final func filter(_ input: String) -> String {
        return wubiFilter(input);
    }
    
    /**
     * 如果输入中包含已编码的中文，返回对应第一个中文的编码<br>
     * 否则截取前4位拼音字符作为返回
     */
    final func translate(_ filteredInput: String) ->[String] {
        if ChineseUtils.hasChinese(filteredInput) {
            let wordWubiMap = CachePool.instance.getCache(CacheNames.WUBI_WORD) as! CharacterLibraryProtocol
            for key in filteredInput.characters {
                if ChineseUtils.isChinese(key) { // 是字典中的汉字，返回编码
                    if wordWubiMap.isKey(key) {
                        return wordWubiMap.getValues(key)!
                    }
                }
            }
        }
        return [filteredInput.substring(to: filteredInput.characters.index(filteredInput.startIndex, offsetBy: 4))]
    }
    
    /**
     * 简化编码的计算过程：<br>
     * 分别截取从前[1-length]位作为dimensionKeys<br>
     */
    override final func computeDimensionKeys(_ simplifyValue: String) ->[String] {
        var rs = [String]()
        for i in 0 ..< simplifyValue.length {
            rs.append(simplifyValue.substring(to: simplifyValue.characters.index(simplifyValue.startIndex, offsetBy: i+1)))
        }
        return rs
    }
    
    static func newInstance() -> ReflectionProtocol {
        return WubiWordStrategyImpl()
    }
}
