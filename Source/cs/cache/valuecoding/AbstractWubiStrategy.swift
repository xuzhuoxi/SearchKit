//
//  AbstractWubiStrategy.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/16.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
class AbstractWubiStrategy : AbstractValueCoding {
    /**
     * 过滤输入，保留中文字符和五笔编码用到的字符<br>
     *
     * @param input
     *            输入字符串
     * @return 过滤处理后的字符串
     */
    final func wubiFilter(_ input: String) ->String {
        if input.isEmpty {
            return input
        }
        sb.removeAll(keepingCapacity: true)
        for char in input.characters {
            if ChineseUtils.isChinese(char) || ChineseUtils.isWubiChar(char) {
                sb.append(char)
            }
        }
        return sb
    }
    
    /**
     * 通过word在wordMap中查找全部值，返回编码长度最长的一个
     *
     * @param wordMap
     *            字(词)库，CharacterLibraryProtocol实例{@link CharacterLibraryProtocol}
     * @param word
     *            字(词)
     * @return 最长的编码
     */
    final func getWubiMaxlenValue(_ wordMap : CharacterLibraryProtocol, word: String) ->String {
        if let values = wordMap.getValues(word.characters.first!) {
            if values.count == 1 {
                return values[0]
            }else {
                var rs = ""
                for value in values {
                    if value.length > rs.length {
                        rs = value
                    }
                }
                return rs
            }
        }
        return ""
    }
}
