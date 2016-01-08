//
//  StringMatching.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/17.
//
//

import Foundation

public struct StringMatching {
    private init(){}
    
    /**
    * 把expression按字母分布到source中，返回分布后命中的索引 当source用完时expression还有剩余则返回null<br>
    * 如：<br>
    * source:"abcde" expression:"abcd"<br>
    * return:[true,true,true,true,false]<br>
    *
    * source:"abcde" expression:"abcde"<br>
    * return:[true,true,true,true,true]<br>
    *
    * source:"abcde" expression:"abcdef"<br>
    * return:null<br>
    *
    * @param source
    *            匹配参照源
    * @param expression
    *            匹配输入
    * @return 布尔数组
    */
    public static func matching(source : String, _ expression : String) -> [Bool]? {
        if expression.length > source.length {
            return nil
        }
        var ei=0;
        var si=0;
        var result = [Bool](count: source.length, repeatedValue: false)
        let emptyChar : String = " "
        var eChar:String;
        var sChar:String;
        var tempSi:Int;
        for (; ei < expression.length; ei++) {
            eChar=expression[ei]!;
            if (emptyChar != eChar) {
                for (; si < source.length; ) {
                    sChar=source[si]!;
                    tempSi=si;
                    si++;
                    if (eChar == sChar) {
                        result[tempSi]=true;
                        if (ei == expression.length - 1) {
                            return result;
                        }
                        break;
                    }
                }
            }
            if (si == source.length) {
                return nil
            }
        }
        return result;
    }
  
    /**
    * 正常值[0,2] 2代表完全匹配
    *
    * @param matchResult
    *            布尔数组
    * @return 返回一个整数值，范围为[0,2]
    */
    public static func computeMatchintResult(matchResult : [Bool]?) ->Double {
        if nil == matchResult || matchResult!.isEmpty {
            return 0
        }
        var rs : Double = 0
        var isFullMatching = true
        var index = -1
        rs = matchResult!.reduce(rs) { (rs : Double, value : Bool) -> Double in
            ++index
            if value {
                return rs + (1.0 / Double(1 << index))
            }else{
                isFullMatching = false
                return rs
            }
        }
        if isFullMatching {
            return 2.0
        }else {
            return rs
        }
    }
}