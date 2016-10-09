//
//  IDCacheProtocol.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/4.
//
//

import Foundation

/**
 * 用于关联检索结果与其它数据
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
    func getIDs(_ key: String) ->[String]?
}
