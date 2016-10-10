//
//  WeightCacheProtocol.swift
//  SearchKit
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
public protocol WeightCacheProtocol: CacheProtocol {
    /**
     * 默认权重
     */
    static var DEFAULT_VALUE:Double{get}
    
    /**
     * 取权重，若key没有记录，则返回默认权重<br>
     *
     * @param key
     *            键
     * @return 权重值
     */
    func getValues(_ key:String) ->Double
}
