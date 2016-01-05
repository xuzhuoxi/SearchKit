//
//  IDCacheProtocol.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 16/1/4.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
public protocol IDCacheProtocol: CacheProtocol {
    /**
     * 取ID列表<br>
     *
     * @param key
     *            键
     * @return ID列表
     */
    func getIDs(key: String) ->[String]?
}