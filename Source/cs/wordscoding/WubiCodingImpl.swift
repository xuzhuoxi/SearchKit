//
//  WubiCodingImpl.swift
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
class WubiCodingImpl : ChineseWordsCoding , ChineseWordsCodingProtocol {
    /**
     * 编码过程：<br>
     * 1.一个字的，返回对应字的编码。<br>
     * 2.两个字的，返回前两个字的最长编码前两个字符的合并字符串。<br>
     * 3.三个字的，返回前三个字的最长编码第一个字符加上第三个字的最长编码第二个字符的合并字符串。<br>
     * 4.四个字或以上的，返回前三个字的的最长编码的第一个字符加最后一个字的最长编码的第一个字符。<br>
     */
    final func coding(_ wordCache: CharacterLibraryProtocol, words: String) -> [String]? {
        if words.isEmpty || !canCoding(wordCache, words) {
            return nil
        }
        var codingResult = [String]()
        let len = words.length
        switch (len) {
        case 1:
            codingResult.append(getMaxValue(wordCache, words.characters.first!))
        case 2:
            codingResult.append(getCode(wordCache, words, [(0,2),(1,2)]))
        case 3:
            codingResult.append(getCode(wordCache, words, [(0,1),(1,1),(2,2)]))
        default:
            codingResult.append(getCode(wordCache, words, [(0,1),(1,1),(2,1),(len-1,1)]))
        }
        return codingResult
    }
    
    fileprivate func getCode(_ wordCache: CharacterLibraryProtocol, _ words: String, _ needs: [(Int, Int)]) ->String{
        var rs = ""
        for (index, len) in needs {
            let word = words[words.characters.index(words.startIndex, offsetBy: index)]
            let maxCode = getMaxValue(wordCache, word)
            rs.append(maxCode.substring(to: maxCode.characters.index(maxCode.startIndex, offsetBy: len)))
        }
        return rs
        
    }
    
    /**
     * 取汉字的最长五笔编码<br>
     *
     * @param wordCache 五笔字库
     * @param word
     * @return
     */
    fileprivate func getMaxValue(_ wordCache: CharacterLibraryProtocol, _ word: Character) ->String {
        if let values = wordCache.getValues(word) {
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
        }else{
            return ""
        }
    }
}
