//
//  ValueCodingStrategyProtocol.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/16.
//
//

import Foundation

/**
 * 值处理接口<br>
 * 使用过程：<br>
 * 情况一：缓存过程。汉字或词的值编码－〉简化－〉计算缓存Key－〉建立缓存Key与汉字或词的影射<br>
 * 情况一: 查看过程。输入字符串－〉过滤－〉翻译－〉简化－〉用于处理(如何处理由外部决定)
 *
 * @author xuzhuoxi
 *
 */
public protocol ValueCodingStrategyProtocol: class {
    /**
     * 简化:对值编码或输入编码进行进一步简化
     *
     * @param value
     *            值数据字符串
     * @return 简化值
     */
    func getSimplifyValue(_ value:String) ->String
    
    /**
     * 获取缓存key
     *
     * @param simplifyValue
     *            简化值
     * @return dimensionKey列表
     */
    func getDimensionKeys(_ simplifyValue:String) ->[String]
    
    /**
     * 过滤输入的字符串
     *
     * @param input
     *            输入字符串
     * @return 过滤后的字符串
     */
    func filter(_ input:String) ->String
    
    /**
     * 翻译
     *
     * @param filteredInput
     *            过滤后的字符串
     * @return 把要翻译的字符进行翻译后得到的字符串数组。
     */
    func translate(_ filteredInput:String) ->[String]
}
