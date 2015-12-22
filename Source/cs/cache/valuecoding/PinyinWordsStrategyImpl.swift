//
//  PinyinWordsStrategyImpl.swift
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
public class PinyinWordsStrategyImpl : AbstractValueCoding , ValueCodingStrategyProtocol {
    /**
    * 单声母
    */
    private let danshengmu:[Character]  = ["b", "p", "m", "f", "d", "t", "n", "l", "g", "k", "h", "j", "q", "x", "r", "z", "c", "s", "w", "y" ];
    /**
    * 空格
    */
    private let space : Character = " ";
    
    override init() {}

    /**
    * 从头开始遍历<br>
    * 遇到以下情况则加入到返回字符串中：<br>
    * 1.第一个字符<br>
    * 2.空格后的第一个字符<br>
    * 3.声母字符<br>
    * 把以上得到的字符按遍历顺序组成字符串返回<br>
    */
    public func getSimplifyValue(value: String) -> String {
        if value.isEmpty {
            return ""
        }
        sb.removeAll(keepCapacity: true)
        var add : Bool = false
        var first = true
        for c in value.characters {
            if c != space {
                if add || first || danshengmu.contains(c) {
                    sb.append(char)
                    add = false
                }
            }else{
                add = true
            }
            first = false
        }
        return sb
    }
    
    public func getDimensionKeys(simplifyValue: String) -> Array<String> {
        return abstractGetDimensionKeys(simplifyValue)
    }

    /**
    * 过滤输入字符串，保留中文字符、拼音字符及空格<br>
    */
    public func filter(input: String) -> String {
        if input.isEmpty {
            return input
        }
        sb.removeAll(keepCapacity: true)
        for c in input.characters {
            if ChineseUtils.isChinese(c) || ChineseUtils.isPinyinChar(c) {
                sb.append(c)
            }
        }
        return sb
    }

    /**
    * 翻译过程：<br>
    * 1.对字符串的中文进行翻译，前后以空格相隔，对于多音字，则进行自由组合<br>
    * 2.对上面的每一个字符串进行简化{@link #getSimplifyValue(String)}<br>
    * 3.返回上一步字符串组成的非重复数组<br>
    *
    * @see #getSimplifyValue(String)
    */
    public func translate(filteredInput : String) ->[String] {
        var rs : [String]
        if ChineseUtils.hasChinese(filteredInput) {
            let wordPinyinMap: ChineseCacheProtocol = CachePool.instance.getCache(CacheNames.PINYIN_WORD)! as! ChineseCacheProtocol
            let indexs = ChineseUtils.getChineseIndexs(filteredInput)
            var values = [[String]]()
            var system = [Int](count: indexs.count, repeatedValue: 0)
            var maxValue = 1
            for i in 0..<indexs.count {
                let key: String = filteredInput[indexs[i]]!
                if wordPinyinMap.isKey(key) {
                    values[i] = wordPinyinMap.getValues(key)
                }else{
                    values[i] = [""]
                }
                system[i] = values[i].count
                maxValue *= system[i]
            }
            rs = [String]()
            for i in 0 ..< maxValue {
                sb.removeAll(keepCapacity: true)
                sb.appendContentsOf(filteredInput)
                let temp = MathUtils.tenToCustomSystem(i, system: system)
                for var j = indexs.count - 1; j>=0; --j {
                    let sourceIndex = indexs[j]
                    let valueIndex = temp[j]
                    let index = sb.startIndex.advancedBy(sourceIndex)
                    sb.removeAtIndex(index)
                    sb.insertContentsOf((" " + values[j][valueIndex] + " ").characters, at: index)
                }
                rs[i] = sb.trimmed()
            }
        }else{
            rs = [filteredInput]
        }
        if !rs.isEmpty {
            for i in 0..<rs.count {
                rs[i] = getSimplifyValue(rs[i])
            }
            ArrayUtils.cleanRepeat(&rs)
        }
        return rs
    }
    
    /**
    * 简化编码的计算过程：<br>
    * 1.截取第二位开始的字符中进行无重复基于顺序的自由组合，详细请看{@link StringCombination}<br>
    * 2.第一位分别拼接上面得的到字符串数组<br>
    * 3.返回第一位字符以及上面的字符串数组组成的数组<br>
    * 
    * @see StringCombination
    */
    override func computeDimensionKeys(simplifyValue : String) ->[String] {
        if simplifyValue.isEmpty {
            return []
        }
        if 1 == simplifyValue.length {
            return [simplifyValue]
        }
        let maxDimension = 2
        let source = simplifyValue.explode(Character(""))
        let subSource : [String] = source[1..<source.count]
        let subRs = StringCombination.getDimensionCombinationArray(subSource, dimensionValue: maxDimension - 1)!
        var rs : [String] = [String](count: subRs.count, repeatedValue: "")
        rs[0] = source[0]
        for i in 1..<rs.count {
            rs[i] = rs[0] + subRs[i-1]
        }
        return rs
    }
}