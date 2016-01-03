//
//  ChineseSearcherProtocol.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

/**
* 不考虑多线程<br>
*
* @author xuzhuoxi
*
*/
public protocol ChineseSearcherProtocol {
//    /**
//    * 检索字，支持范围：<br>
//    * 拼音、五笔
//    *
//    * @param input
//    *            检索输入字符串
//    * @param max
//    *            返回最大检索结果量
//    * @return 检索结果数组
//    */
//    func searchWord(input: String, _ max: Int) ->[SearchKeyResult]?
//    /**
//    * 检索词，支持范围:<br>
//    * 拼音、五笔
//    *
//    * @param input
//    *            检索输入字符串
//    * @param max
//    *            返回最大检索结果量
//    * @return 检索结果数组
//    */
//    func searchWords(input: String, _ max: Int) ->[SearchKeyResult]?
    /**
    * 检索
    *
    * @param input
    *            检索输入字符串
    * @param searchType
    *            自定义检索类型
    * @return SearchResult实例{@link SearchResult}
    */
    func search(input:String, searchTypes:[SearchType]) ->SearchResult?
}