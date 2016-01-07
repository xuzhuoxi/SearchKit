//
//  SearchKiterProtocol.swift
//  SearchKit
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
    /**
    * 检索
    *
    * @param input
    *            检索输入字符串
    * @param searchType
    *            自定义检索类型
    * @return SearchResult实例{@link SearchResult}
    */
    func search(input: String, searchConfig: SearchConfig) ->SearchResult?
    
    /**
     * 检索
     *
     * @param input
     *            检索输入字符串
     * @param searchType
     *            自定义检索类型
     * @param max
     *            最大结果量
     * @return SearchKeyResult实例{@link SearchKeyResult}
     */
    func search(input: String, searchConfig: SearchConfig, max: Int) ->[SearchKeyResult]?
}