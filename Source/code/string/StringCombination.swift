//
//  StringCombination.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/18.
//
//

import Foundation

public struct StringCombination {
    private init(){}
    
    /**
    * 使用字符串数组进行组合<br>
    * 组合过程是按顺序的，即不会出现source[1]+source[0]这重情况<br>
    *
    * @param source
    *            字符串数据源
    * @param dimension
    *            维度，指组合最多使用的字符串数
    * @param repeat
    *            是否允许重复
    * @return 二维数组，第一个数组为只有1个source元素的字符串数组，第二个为2个source元素，如止类推<br>
    */
    public static func getTwoDimensionArray(source : [String], dimensionValue : Int, isRepeat : Bool = false) ->[[String]]? {
        return dimension(source, dimensionValue, isRepeat);
    }
    
    /**
    * 使用字符串数组进行组合<br>
    * 组合过程是按顺序的，即不会出现source[1]+source[0]这重情况<br>
    *
    * @param source
    *            字符串数据源
    * @param dimension
    *            维度，指组合最多使用的字符串数
    * @param repeat
    *            是否允许重复
    * @return 一维数组<br>
    */
    public static func getDimensionCombinationArray(source : [String], dimensionValue : Int, isRepeat : Bool = false) ->[String]? {
        if let temp = dimension(source, dimensionValue, isRepeat) {
            return dimensionalityReduction(temp, isRepeat)
        }else{
            return nil
        }
    }
    
    
    /**
    * 把二维字符串数组降为一维字符串数组
    *
    * @param arrTwo
    *            二维字符串数组
    * @param repeat
    *            是否允许重复
    * @return 一维字符串数组
    */
    public static func dimensionalityReduction(arrTwo : [[String]], _ isRepeat : Bool = true) ->[String] {
        var rs = ArrayUtils.dimensionalityReduction(arrTwo)
        if !isRepeat {
            ArrayUtils.cleanRepeat(&rs)
        }
        return rs
    }
    
    /**
    * 使用字符串数组进行组合<br>
    * 组合过程是按顺序的，即不会出现source[1]+source[0]这重情况<br>
    * 为提高效率，区分了dimension=1,dimension=2,dimension>2三种情况进行处理
    *
    * @param source
    *            字符串数据源
    * @param newDimension
    *            维度，指组合最多使用的字符串数
    * @param repeat
    *            是否允许重复
    * @return 二维数组，第一个数组为只有1个source元素的字符串数组，第二个为2个source元素，如止类推<br>
    */
    private static func dimension(source : [String], _ dimensionValue : Int, _ isRepeat : Bool = false) ->[[String]]? {
        let newDimension = min(source.count, dimensionValue)
        if newDimension < 1 {
            return nil
        }
        if 1 == newDimension {
            return dimensionOne(source, isRepeat: isRepeat)
        }
        if let indexs = MathUtils.getDimensionCombinationIndex(source.count, dimension: newDimension) {
            var sb:String = "";
            var rs = [[String]]()
            for i in 0..<indexs.count {
                rs.append([String](count: indexs[i].count, repeatedValue: ""))
                for j in 0..<rs[i].count {
                    sb.removeAll(keepCapacity: true)
                    for index in indexs[i][j] {
                        sb.appendContentsOf(source[index])
                    }
                    rs[i][j] = sb
                }
                if !isRepeat {
                    ArrayUtils.cleanRepeat(&rs[i])
                }
            }
            return rs
        }else{
            return nil
        }
    }
    
    private static func dimensionOne(var source : [String], isRepeat : Bool) ->[[String]] {
        if !isRepeat {
            ArrayUtils.cleanRepeat(&source)
        }
        return [source]
    }
}
