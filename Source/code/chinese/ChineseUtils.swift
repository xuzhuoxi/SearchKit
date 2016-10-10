//
//  ChineseUtils.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/17.
//
//

import Foundation

/**
 * 汉字范围[0x4e00,0x9fa5]
 *
 * @author xuzhuoxi
 *
 */
public struct ChineseUtils {
    public static let chineseStartChar : Character = "\u{4e00}"
    public static let chineseEndChar : Character = "\u{9fa5}"
    public static let chineseStartUnicode : UInt32 = 0x4e00
    public static let chineseEndUnicode : UInt32 = 0x9fa5
    
    fileprivate static var sb:String = ""
    
    fileprivate static let someChinese = "[\u{4e00}-\u{9fa5}]*"
    fileprivate static let endStr = "$"
    
    fileprivate init(){}
    
    public static let chineseSize: Int = Int(ChineseUtils.chineseEndUnicode - ChineseUtils.chineseStartUnicode + 1)
    
    /**
     * 检测是否为中文字符<br>
     * 注：中文字符指是中国字，不包括中文标点
     *
     * @param word
     *            待判断的字符
     * @return 是中文字符返回true,否则返回false。
     */
    public static func isChinese(_ word : Character) ->Bool {
        return word >= chineseStartChar && word <= chineseEndChar;
    }
    
    /**
     * 检测是否为中文字符<br>
     * 注：中文字符指是中国字，不包括中文标点
     *
     * @param word
     *            待判断的字符
     * @return 是中文字符返回true,否则返回false。
     */
    public static func inChineseUnicodeArea(_ value: UInt32) ->Bool {
        return value >= chineseStartUnicode && value <= chineseEndUnicode
    }
    
    /**
     * 检测字符串中是否含有中文字符<br>
     * 注：中文字符指是中国字，不包括中文标点
     *
     * @param words
     *            待判断的字符串
     * @return 字符串包含中文字符返回true,否则返回false。
     */
    public static func hasChinese(_ words : String) ->Bool {
        var b = false
        for char in words.unicodeScalars {
            b = inChineseUnicodeArea(char.value)
            if b {
                return true
            }
        }
        return false
    }
    
    /**
     * 获得字符串中的中文字符索引号
     *
     * @param words
     *            待计算字符串
     * @return 返回每个中文字符返回字符串中的索引组成的数组。
     */
    public static func getChineseIndexs(_ words : String) -> [Int] {
        if words.isEmpty || !hasChinese(words) {
            return []
        }
        
        var temp=[Int]()
        var index = 0
        for char in words.unicodeScalars {
            if inChineseUnicodeArea(char.value) {
                temp.append(index)
            }
            index += 1
        }
        return temp
    }
    
    /**
     * 计算字符串中的针对中文字符而成的正则表达式
     *
     * @param chineseInput
     *            包含中文字符的字符串
     * @return 字符串形式的正则表达式
     */
    public static func toChineseWordsRegexp(_ chineseInput : String) ->String? {
        if chineseInput.isEmpty || !hasChinese(chineseInput) {
            return nil
        }
        sb.removeAll(keepingCapacity: true)
        sb.append("^")
        var isPC = true
        var isC = false
        var first = true
        for char in chineseInput.unicodeScalars {
            isC = inChineseUnicodeArea(char.value)
            if isC {
                sb.append(String(char))
            }else if first || isPC {
                sb.append(someChinese)
            }
            isPC = isC
            first = false
        }
        if isPC {
            sb.append(someChinese)
        }
        sb.append(endStr)
        return sb
    }
    
    /**
     * 判断字符是否为拼音所用到的字符(不区分大小写)
     * 拼音编码范围：[a-z],[A-Z]
     *
     * @param c
     *            待判断的字符
     * @return 如果是中文拼音所使用到的字符，则返回true，否则返回false。<br>
     *
     */
    public static func isPinyinChar(_ c : Character) ->Bool {
        return (c >= "\u{0041}" && c <= "\u{005A}") || (c >= "\u{0061}" && c <= "\u{007A}")
    }
    
    /**
     * 判断字符是否为五笔所用到的字符(不区分大小写，忽略z)
     * 五笔编码范围：[a-z),[A-Z)
     *
     * @param c
     *            待判断的字符
     * @return 如果是中文五笔所使用到的字符，则返回true，否则返回false。<br>
     */
    public static func isWubiChar(_ c : Character) ->Bool {
        return (c >= "\u{0041}" && c < "\u{005A}") || (c >= "\u{0061}" && c < "\u{007A}")
    }
}
