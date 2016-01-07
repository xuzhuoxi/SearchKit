//
//  CacheProtocol.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/16.
//
//

import Foundation

/**
 * 实例必须保留空的构造方法<br>
 *
 * @author xuzhuoxi
 *
 */
public protocol CacheProtocol : class {
    /**
     * 取得当前实例在实例化期间被赋予的名字
     *
     * @return 取得当前实例在实例化期间被赋予的名字
     */
    var cacheName: String {get}
    
    /**
     * 缓存Key数
     *
     * @return 缓存Key数
     */
    var keysSize: Int {get}
    
    /**
     * 检测key是否被缓存起来
     *
     * @param key
     *            键
     * @return 有true无false
     */
    func isKey(key:String) ->Bool
}

