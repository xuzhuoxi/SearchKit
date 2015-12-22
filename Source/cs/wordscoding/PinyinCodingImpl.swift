//
//  PinyinCodingImpl.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/22.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
public class PinyinCodingImpl : ChineseWordsCoding , ChineseWordsCodingProtocol {
    /**
    * 编码过程：<br>
    * 1.验证可编码性。<br>
    * 2.取每个汉字的拼音编码数组分别作自由组合，中间补充空间。<br>
    */
    public func coding(wordCache: ChineseCacheProtocol, words: String) -> [String]? {
        if words.isEmpty || !canCoding(wordCache, words) {
            return nil
        }
        var values = [[String]]()
        var size = 1
        for char in words.characters {
            let value = wordCache.getValues(String(char))
            values.append(value)
            size *= value.count
        }
        var rs = [String](count: size, repeatedValue: "")
        for (i, var sb) in rs.enumerate() {
            for strAry in values {
                let index = i % strAry.count
                sb.appendContentsOf(strAry[index] + " ")
            }
            rs[i] = sb.substringToIndex(sb.endIndex.advancedBy(-1))
        }
        return rs
    }
}
