//
//  ArrayUtils.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/17.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
public struct ArrayUtils {
    private init(){}
    
    /**
     * 清除数组中重复项（去除尾部的重复项）
     * 修改原数组
     *
     * @param ary
     *            输入数组
     */
    public static func cleanRepeat<T : Equatable>(inout arr : [T]) {
        for var i:Int = arr.count-1; i >= 0; --i {
            if arr.indexOf(arr[i])! != i {
                arr.removeAtIndex(i)
            }
        }
    }
    
    /**
     * 把二维数组降为一维数组
     *
     * @param arrTwo
     *            源二维数组
     * @return 新的一维数组
     */
    public static func dimensionalityReduction<T>(arrTwo : [[T]]) ->[T] {
        return mergeArray(arrTwo)
    }
    
    /**
     * 把二维数合并为一维数组
     *
     * @param arrTwo
     *            源二维数组
     * @return 新的一维数组
     */
    public static func mergeArray<T>(arrTwo : [[T]]) ->[T] {
        return arrTwo.reduce([], combine: (+) )
    }
}
