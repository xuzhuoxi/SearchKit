//
//  WubiWordsStrategyImpl.swift
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
class WubiWordsStrategyImpl : AbstractWubiStrategy, ValueCodingStrategyProtocol, ReflectionProtocol {
    
    final func getSimplifyValue(_ value: String) -> String {
        return value;
    }
    
    final func getDimensionKeys(_ simplifyValue: String) ->[String] {
        return abstractGetDimensionKeys(simplifyValue);
    }
    
    final func filter(_ input: String) -> String {
        return wubiFilter(input)
    }
    
    /**
     * 翻译<br>
     * <br>
     * 从开始遍历input，如果是以下情况：<br>
     * 是中文字符，取最长编码的第一个字符<br>
     * 是五笔字符，直接取出<br>
     * 如果长度到达4或input遍历结束，返回以上字符的顺序字符串<br>
     *
     * @param filteredInput
     *            过滤后的字符串
     * @return 把要翻译的字符进行翻译后得到的字符串数组。
     */
    final func translate(_ filteredInput: String) ->[String] {
        sb.removeAll(keepingCapacity: true)
        let wordWubiMap = CachePool.instance.getCache(CacheNames.WUBI_WORD) as! CharacterLibraryProtocol
        var len = 0
        var i = 0
        while i < filteredInput.length && len < 4 {
            let keyStr : String = filteredInput[i]!
            let keyChar : Character = Character(keyStr)
            if ChineseUtils.isChinese(keyChar) {
                if wordWubiMap.isKey(keyStr) {
                    sb.append(getWubiMaxlenValue(wordWubiMap, word: keyStr))
                }
            }else{
                sb.append(keyChar)
                len += 1
            }
            i += 1
        }
        return [sb]
    }
    
    /**
     * 计算简化编码<br>
     * <br>
     * 简化编码的计算过程：<br>
     * 分别截取从前[1-length]位作为dimensionKeys<br>
     *
     * @param simplifyValue
     *            简化输入
     * @return 计算得到的dimensionKey列表
     */
    override final func computeDimensionKeys(_ simplifyValue: String) ->[String] {
        var rs = [String]()
        for i in 0 ..< simplifyValue.length {
            rs.append(simplifyValue.substring(to: simplifyValue.characters.index(simplifyValue.startIndex, offsetBy: i+1)))
        }
        return rs
    }
    
    static func newInstance() -> ReflectionProtocol {
        return WubiWordsStrategyImpl()
    }
}
