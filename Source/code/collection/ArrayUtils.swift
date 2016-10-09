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
    fileprivate init(){}
    
    /**
     * 清除数组中重复项（去除尾部的重复项）
     * 修改原数组
     *
     * @param ary
     *            输入数组
     */
    public static func cleanRepeat<T : Equatable>(_ arr : inout [T]) {
        for i in (0..<arr.count).reversed() {
            if arr.index(of: arr[i])! != i {
                arr.remove(at: i)
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
    public static func dimensionalityReduction<T>(_ arrTwo : [[T]]) ->[T] {
        return mergeArray(arrTwo)
    }
    
    /**
     * 把二维数合并为一维数组
     *
     * @param arrTwo
     *            源二维数组
     * @return 新的一维数组
     */
    public static func mergeArray<T>(_ arrTwo : [[T]]) ->[T] {
        return arrTwo.reduce([], (+) )
    }
}
