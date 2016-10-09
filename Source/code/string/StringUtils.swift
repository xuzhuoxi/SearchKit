//
//  StringUtils.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/18.
//
//

import Foundation

public struct StringUtils {
    fileprivate init(){}
    /**
    * 如果源字符串中有相同的字符，则去掉后面的<br>
    *
    * @param str
    *            源字符串
    * @return 新的字符串
    */
    public static func toNonRepeatString(_ str:String) ->String{
        if str.isEmpty {
            return str
        }
        var rs : String = ""
        for char in str.characters {
            if rs.characters.contains(char) {
                continue
            }
            rs.append(char)
        }
        return rs
    }
    
    /**
    * 根据源字符串，构造新的字符串
    *
    * @param source
    *            源字符串
    * @param includeIndex
    *            源字符串的下标数组，新字符串由源字符串对应下标字符组成
    * @return 新的字符串
    */
    public static func structString(_ source : String, includeIndex:[Int]) ->String {
        var rs = ""
        for index in includeIndex {
            rs.append(source[source.characters.index(source.startIndex, offsetBy: index)])
        }
        return rs
    }
    
    /**
    *
    * 根据源字符串，构造新的字符串
    *
    * @param source
    *            源字符串
    * @param ignoreIndex
    *            忽略的源字符下标
    * @return 新的字符串
    */
    public static func structString(_ source :String, ignoreIndex:Int) ->String {
        if source.isEmpty || ignoreIndex < 0 || ignoreIndex >= source.length {
            return source
        }
        let index = source.index(source.startIndex, offsetBy: ignoreIndex)
        return source.substring(to: index) + source.substring(from: source.index(index, offsetBy: 1))
    }
    
    /**
    * 从一个StringBuilder实例中移除若干个字符
    *
    * @param source
    *            StringBuilder实例
    * @param excludeIndex
    *            下标数组，自动去掉重复
    */
    public static func removeChars(_ source : String, excludeIndex : [Int]) ->String {
        var source = source
        var indexs = excludeIndex.sorted(by: >)
        ArrayUtils.cleanRepeat(&indexs)
        for index in indexs {
            if index.isIn(0..<source.characters.count) {
                source.remove(at: source.characters.index(source.startIndex, offsetBy: index))
            }
        }
        return source
    }

    /**
    * 无重复组合<br>
    * 由源字符串中的字符进行组合，得到的组合字符符合源字符串顺序，如：<br>
    * 源"abc"，只会产出"ab"不会产出"ba"<br>
    *
    * @param source
    *            源字符串
    * @param factorialLevel
    *            组合维度，最多使用多少个字符进行组合
    * @return 组合字符串数组
    */
    public static func nonRepeatFactorial(_ source : String, factorialLevel : Int) ->[String]? {
        if factorialLevel <= 0 {
            return nil
        }
        let newSource = source.explode()
        return StringCombination.getDimensionCombinationArray(newSource, dimensionValue: factorialLevel);
    }
}
