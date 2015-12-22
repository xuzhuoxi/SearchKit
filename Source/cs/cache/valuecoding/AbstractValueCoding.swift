//
//  AbstractValueCoding.swift
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
public class AbstractValueCoding {
    var sb : String = ""
    var simplifyValueKeysMap :Dictionary<String,Array<String>> = Dictionary<String,Array<String>>()
    
    init(){}
    
    /**
    * 如果缓存中没有，则调用子类的{@link #computeDimensionKeys(String)}方法进行计算
    *
    * @param simplifyValue
    *            简化输入
    * @return 计算得到的dimensionKey列表
    */
    final func abstractGetDimensionKeys(simplifyValue:String) ->Array<String> {
        if let value = simplifyValueKeysMap[simplifyValue] {
            return value
        }else{
            let newValue = computeDimensionKeys(simplifyValue)
            simplifyValueKeysMap[simplifyValue] = newValue
            return newValue
        }
    }
    
    /**
     * 计算简化编码
     *
     * @param simplifyValue
     *            简化输入
     * @return 计算得到的dimensionKey列表
     */
    func computeDimensionKeys(simplifyValue:String) ->Array<String> {
        return []
    }
}