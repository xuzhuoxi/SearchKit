//
//  AbstractWubiStrategy.swift
//  ChineseSearch
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
    final func wubiFilter(input: String) ->String {
        if input.isEmpty {
            return input
        }
        sb.removeAll(keepCapacity: true)
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
     *            字(词)库，IChineseCache实例{@link IChineseCache}
     * @param word
     *            字(词)
     * @return 最长的编码
     */
    final func getWubiMaxlenValue(wordMap : ChineseCacheProtocol, word: String) ->String {
        let values = wordMap.getValues(word)
        if values.isEmpty {
            return ""
        }else if values.count == 1 {
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
}