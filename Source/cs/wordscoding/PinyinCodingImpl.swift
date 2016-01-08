//
//  PinyinCodingImpl.swift
//  SearchKit
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
class PinyinCodingImpl : ChineseWordsCoding , ChineseWordsCodingProtocol {
    /**
     * 编码过程：<br>
     * 1.不可编码部分作为编码保留，可编码则求取编码。
     * 2.编码数组作自由组合，中间补充空格。<br>
     */
    final func coding(wordCache: CharacterLibraryProtocol, words: String) -> [String]? {
        if words.isEmpty {
            return nil
        }
        let parts = participles(wordCache, words: words)
        
        var values = [[String]]()
        var size = 1
        for part in parts {
            if part.length > 1 || !wordCache.isKey(part) {
                values.append([part])
            }else{
                values.append(wordCache.getValues(part.characters.first!)!)
                size *= values[values.count-1].count
            }
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
    
    final private func participles(wordCache: CharacterLibraryProtocol, words: String) ->[String] {
        var temp = [String]()
        var sb = ""
        for word in words.characters {
            if (wordCache.isKey(word)) {
                if (sb.length > 0) {
                    temp.append(sb)
                    sb.removeAll(keepCapacity: true)
                }
                temp.append(String(word))
            } else {
                sb.append(word)
            }
        
        }
        if (sb.length > 0) {
            temp.append(sb)
        }
        return temp
    }
}
